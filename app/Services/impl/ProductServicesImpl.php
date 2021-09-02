<?php

namespace App\Services\impl;

use App\Dict\ResponseJsonData;
use App\Exceptions\InvalidRequestException;
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
     * @return array
     */
    public function getProductLists($search = null, $order = null): array
    {
        $builder = Product::query()->where('on_sale', true);

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
     * @throws InvalidRequestException
     * @return JsonResponse
     */
    public function getProductDetail($product): JsonResponse
    {
        if (!$product->on_sale) {
            throw new InvalidRequestException('商品未上架');
        }
        $skus = $product->skus->toArray();
        $result = [
            'product' => $product,
            'skus' => $skus,
        ];

        return ResponseJsonData::responseOk($result);
    }
}
