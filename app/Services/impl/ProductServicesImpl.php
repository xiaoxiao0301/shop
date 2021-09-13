<?php

namespace App\Services\impl;

use App\Dict\ResponseJsonData;
use App\Exceptions\InvalidRequestException;
use App\Models\Category;
use App\Models\OrderItem;
use App\Models\Product;
use App\Services\ProductServicesIf;
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
        $reviews = OrderItem::query()
            ->where('product_id', $product->id)
            ->with(['order.user', 'productSku']) // 预先加载关联关系
            ->whereNotNull('reviewed_at') // 筛选出已评价的
            ->orderBy('reviewed_at', 'desc')
            ->limit(10)
            ->get()
            ->toArray();
        return [
            'product' => $product->toArray(),
            'skus' => $skus,
            'reviews' => $reviews
        ];
    }
}
