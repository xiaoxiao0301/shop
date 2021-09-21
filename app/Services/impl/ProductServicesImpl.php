<?php

namespace App\Services\impl;

use App\Dict\ResponseJsonData;
use App\Exceptions\InvalidRequestException;
use App\Models\Category;
use App\Models\OrderItem;
use App\Models\Product;
use App\SearchBuilders\ProductSearchBuilder;
use App\Services\ProductServicesIf;
use DB;
use Illuminate\Database\Query\Builder;
use Illuminate\Http\JsonResponse;

class ProductServicesImpl implements ProductServicesIf
{
    /**
     * 获取所有上架商品
     *
     * @param null $search
     * @param null $order
     * @param null $category
     * @return array
     */
    public function getProductListsByShopId($search = null, $order = null, $category = null, $shopId = null): array
    {
        $builder = Product::query()->where('on_sale', true);

        if (!is_null($shopId)) {
            $builder->where('shop_id', $shopId);
        }

        if (!is_null($category)) {
           if ($category->is_directory) {
               // 父目录
               $builder->whereHas('category', function ($query) use ($category) {
                   /** @var Builder $query */
                   $query->where('path', 'like', $category->path. $category->id . '%');
               });
           } else {
               // 单个子类
               $builder->where('category_id', $category->id);
           }
        }

        // 关键字查询
        if (!is_null($search)) {
            $queryWords = '%' . $search. '%';
            $builder->where(function ($query) use($queryWords) {
                /** @var Builder $query */
                $query->where('title', 'like', $queryWords)
                    ->orWhere('description', 'like', $queryWords)
                    ->orWhereHas('skus', function ($query) use($queryWords) {
                        /** @var Builder $query */
                        $query->where('title', 'like', $queryWords)
                            ->orWhere('description', 'like', $queryWords);
                    });
            });
        }

        // 排序
        if (!is_null($order)) {
            // price_asc
            if (preg_match('/^(.+)_(asc|desc)$/', $order, $result)) {
                if (in_array($result[1], ['price', 'sold_count', 'rating'])) {
                    $builder->orderBy($result[1], $result[2]);
                }
            }
        }
        return $builder->get()->toArray();
    }

    /**
     * 商品详情
     *
     * @param $product
     * @return array
     * @throws InvalidRequestException
     */
    public function getProductDetail($product): array
    {
        if (!$product->on_sale) {
            throw new InvalidRequestException('商品未上架');
        }
        $skus = $product->skus->toArray();
        $properties = $product->properties->toArray();
        $reviews = OrderItem::query()
            ->where('product_id', $product->id)
            ->with(['order.user', 'productSku']) // 预先加载关联关系
            ->whereNotNull('reviewed_at') // 筛选出已评价的
            ->orderBy('reviewed_at', 'desc')
            ->limit(10)
            ->get()
            ->toArray();

        // 相似商品，推荐功能
        $similarProductIds = $this->getSimilarProductIds($product, 4);
        // 根据 Elasticsearch 搜索出来的商品 ID 从数据库中读取商品数据
        $similarProducts = Product::query()->byIds($similarProductIds)->get();
//        $similarProducts   = Product::query()
//            ->whereIn('id', $similarProductIds)
//            ->orderByRaw(sprintf("FIND_IN_SET(id, '%s')", join(',', $similarProductIds)))
//            ->get();

        return [
            'product' => $product->toArray(),
            'skus' => $skus,
            'properties' => $properties,
            'reviews' => $reviews,
            'similar' => $similarProducts,
        ];
    }

    /**
     * 获取推荐商品IDS
     *
     * @param Product $product
     * @param $amount
     * @return array
     */
    public function getSimilarProductIds(Product $product, $amount)
    {
        // 如果商品没有商品属性，则直接返回空
        if (count($product->properties) === 0) {
            return [];
        }
        // 相似商品，推荐功能
        $builder = (new ProductSearchBuilder())->onSale()->paginate($amount, 1);
        foreach ($product->properties as $property) {
            // 添加到 should 条件中
            $builder->propertyFilter($property->name, $property->value, 'should');
        }
        // 设置最少匹配一半属性
        $builder->minShouldMatch(ceil(count($product->properties) / 2));
        $params = $builder->getParams();
        // 同时将当前商品的 ID 排除
        $params['body']['query']['bool']['must_not'] = [['term' => ['_id' => $product->id]]];
        // 搜索
        $result = app('es')->search($params);
        return collect($result['hits']['hits'])->pluck('_id')->all();
    }


    public function getProductListsFromEs($page, $size, $search = null, $order = null, $category = null, $filter = null, $shopId = null)
    {
        $builder = (new ProductSearchBuilder())->onSale()->paginate($size, $page);

        if (!is_null($category)) {
            // 调用查询构造器的类目筛选
            $builder->category($category);
        }

        if (!is_null($search)) {
            $keywords = array_filter(explode(' ', $search));
            // 调用查询构造器的关键词筛选
            $builder->keywords($keywords);
        }

        // 只有当用户有输入搜索词或者使用了类目筛选的时候才会做聚合
        if (!is_null($search) || !is_null($category) ){
            $builder->aggregateProperties();
        }

        // 属性值查询
        $propertyFilters = [];
        if (!is_null($filter)) {
            // 将获取到的字符串用符号 | 拆分成数组
            $filterArray = explode('|', $filter);
            foreach ($filterArray as $filterString) {
                [$name, $value] = explode(':', $filterString);
                // 将用户筛选的属性添加到数组中
                $propertyFilters[$name] = $value;
                // 由于我们要筛选的是 nested 类型下的属性，因此需要用 nested 查询
                $builder->propertyFilter($name, $value);
            }
        }

        // 排序
        if (!is_null($order)) {
            if (preg_match('/^(.+)_(asc|desc)$/', $order, $result)) {
                if (in_array($result[1], ['price', 'sold_count', 'rating'])) {
                    $builder->orderBy($result[1], $result[2]);
                }
            }
        }

        $result = app('es')->search($builder->getParams());
        $countNumber = $result['hits']['total']['value'];
        $totalPage = ceil($countNumber / $size);
        // 通过 collect 函数将返回结果转为集合，并通过集合的 pluck 方法取到返回的商品 ID 数组
        $productIds = collect($result['hits']['hits'])->pluck('_id')->all();
//        $products = Product::query()
//            ->whereIn('id', $productIds)
//             根据指定顺序返回数据
//            ->orderByRaw(DB::raw("FIND_IN_SET(id, '" . implode(',', $productIds) . "'" . ')'))
//            ->orderByRaw(sprintf("FIND_IN_SET(id, '%s')", join(',', $productIds)))
//            ->get();
        // 调用模型的局部作用域
        $products = Product::query()->byIds($productIds)->get();

        $categoryTreeData = $this->productListsWithCategoryNameAndSubCategoryName($category);

        $properties = [];
        // 如果返回结果里有 aggregations 字段，说明做了分面搜索
        if (isset($result['aggregations'])) {
            // 使用 collect 函数将返回值转为集合
            $properties = collect($result['aggregations']['properties']['properties']['buckets'])
                ->map(function ($bucket) {
                    // 通过 map 方法取出我们需要的字段
                    return [
                        'key'    => $bucket['key'],
                        'values' => collect($bucket['value']['buckets'])->pluck('key')->all(),
                    ];
                })
                ->filter(function ($property) use ($propertyFilters) {
                    // 过滤掉只剩下一个值 或者 已经在筛选条件里的属性
                    return count($property['values']) > 1 && !isset($propertyFilters[$property['key']]) ;
                });
        }

        $result = [
            'products' => $products,
            'category' => $categoryTreeData,
            'filter' => [
                'order' => $order,
                'search' => $search,
            ],
            'total_page' => $totalPage,
            'current_page' => $page,
            'properties' => $properties,
            'propertyFilters' => $propertyFilters,
        ];
        return ResponseJsonData::responseOk($result);

    }
   /* public function getProductListsFromEs($page, $size, $search = null, $order = null, $category = null, $filter = null, $shopId = null)
    {
        $queryParams = [
            'index' => 'product',
            'body' => [
                'from' => ($page - 1) * $size,
                'size' => $size,
                'query' => [
                    'bool' => [
                        'filter' => [
                            [
                                'term' => [
                                    'on_sale' => true
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ];

        // 类目
        if (!is_null($category)) {
            if ($category->is_directory) {
                // 父目录, 使用 category_path 来筛选, 前缀查询
                $queryParams['body']['query']['bool']['filter'][] = [
                    'prefix' => [
                        'category_path' => $category->path . $category->id . '-'
                    ],
                ];
            } else {
                // 单个子类, 通过 category_id 筛选
                $queryParams['body']['query']['bool']['filter'][] = ['term' => ['category_id' => $category->id]];
            }
        }


        // 关键词
        if (!is_null($search)) {
            // 将搜索词根据空格拆分成数组，并过滤掉空项
            $keywords = array_filter(explode(' ', $search));
            $queryParams['body']['query']['bool']['must'] = [];
            foreach ($keywords as $keyword) {
                $queryParams['body']['query']['bool']['must'][] = [
                    'multi_match' => [
                        'query' => $keyword,
//                        'operator' => 'and',
//                        'type' => 'most_fields',
                        'fields' => [
                            'title^3',
                            'long_title^2',
                            'category^2', // 类目名称
                            'description',
                            'skus.title',
                            'skus.description',
                            'properties.value',
                        ],
                    ],
                ];
            }
        }

        // 只有当用户有输入搜索词或者使用了类目筛选的时候才会做聚合
        if (!is_null($search) || !is_null($category)) {
            $queryParams['body']['aggs'] = [
                'properties' => [
                    'nested' => [
                        'path' => 'properties',
                    ],
                    'aggs'   => [
                        'properties' => [
                            'terms' => [
                                'field' => 'properties.name',
                            ],
                            'aggs'  => [
                                'value' => [
                                    'terms' => [
                                        'field' => 'properties.value',
                                    ],
                                ],
                            ],
                        ],
                    ],
                ],
            ];
        }

        // 定义一个数组
        $propertyFilters = [];
        if (!is_null($filter)) {
            // 将获取到的字符串用符号 | 拆分成数组
            $filterArray = explode('|', $filter);
            foreach ($filterArray as $filterString) {
                [$name, $value] = explode(':', $filterString);
                // 将用户筛选的属性添加到数组中
                $propertyFilters[$name] = $value;
                $queryParams['body']['query']['bool']['filter'][] = [
                    // 由于我们要筛选的是 nested 类型下的属性，因此需要用 nested 查询
                    'nested' => [
                        // 指明 nested 字段
                        'path' => 'properties',
                        'query' => [
                            ['term' => ['properties.search_value' => $filter]],
                        ]
                    ]
                ];
            }
        }


        // 排序
        if (!is_null($order)) {
            if (preg_match('/^(.+)_(asc|desc)$/', $order, $result)) {
                if (in_array($result[1], ['price', 'sold_count', 'rating'])) {
                    $queryParams['body']['sort'] = [$result[1] => $result[2]];
                }
            }
        }


        $result = app('es')->search($queryParams);
        $countNumber = $result['hits']['total']['value'];
        $totalPage = ceil($countNumber / $size);
        // 通过 collect 函数将返回结果转为集合，并通过集合的 pluck 方法取到返回的商品 ID 数组
        $productIds = collect($result['hits']['hits'])->pluck('_id')->all();
        $products = Product::query()
            ->whereIn('id', $productIds)
            // 根据指定顺序返回数据
            ->orderByRaw(DB::raw("FIND_IN_SET(id, '" . implode(',', $productIds) . "'" . ')'))
//            ->orderByRaw(sprintf("FIND_IN_SET(id, '%s')", join(',', $productIds)))
            ->get();

        $categoryTreeData = $this->productListsWithCategoryNameAndSubCategoryName($category);

        $properties = [];
        // 如果返回结果里有 aggregations 字段，说明做了分面搜索
        if (isset($result['aggregations'])) {
            // 使用 collect 函数将返回值转为集合
            $properties = collect($result['aggregations']['properties']['properties']['buckets'])
                ->map(function ($bucket) {
                    // 通过 map 方法取出我们需要的字段
                    return [
                        'key'    => $bucket['key'],
                        'values' => collect($bucket['value']['buckets'])->pluck('key')->all(),
                    ];
                })
                ->filter(function ($property) use ($propertyFilters) {
                    // 过滤掉只剩下一个值 或者 已经在筛选条件里的属性
                    return count($property['values']) > 1 && !isset($propertyFilters[$property['key']]) ;
                });
        }

        $result = [
            'products' => $products,
            'category' => $categoryTreeData,
            'filter' => [
                'order' => $order,
                'search' => $search,
            ],
            'total_page' => $totalPage,
            'current_page' => $page,
            'properties' => $properties,
            'propertyFilters' => $propertyFilters,
        ];
        return ResponseJsonData::responseOk($result);
    }
*/

    protected function productListsWithCategoryNameAndSubCategoryName(Category $category = null)
    {
        $resultDataTemple = [];
        if (!is_null($category)) {
            $parentCategory = $category->ancestors;
            if ($parentCategory->isEmpty()) {
                $resultDataTemple['category_name'] = $category->id . '_' . $category->name;
            } else {
                $str = "";
                foreach ($parentCategory as $item) {
                    $str .= $item->id . '_' . $item->name . '_';
                }
                $str .= $category->id . '_' . $category->name;
//                dump($str);  1_手机配件_7_耳机_8_有线耳机
//                dd(explode('_', $str)); [ 0 => "1" , 1 => "手机配件"  2 => "7"  3 => "耳机"  4 => "8"  5 => "有线耳机"]
                $resultDataTemple['category_name'] = $str;
            }

            // 从这个可以区分是父目录查询还是子目录查询
            if ($category->is_directory) {
                $str = "";
                foreach ($category->children as $child) {
                    $str .= $child->id . '_' . $child->name . '_';
                }
                $resultDataTemple['sub_category_name'] = $str;
            }

        }

        return $resultDataTemple;
    }

}
