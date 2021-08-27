<?php

namespace App\Services\impl;

use App\Models\Product;
use App\Models\User;
use App\Services\ProductServicesIf;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\DB;

class ProductServicesImpl implements ProductServicesIf
{

    /**
     * 获取所有商品
     *
     * @return Builder[]|Collection
     */
    public function getProducts()
    {
        return Product::query()
            ->where('on_sale', true)
            ->orderBy('created_at', 'desc')
            ->get();
    }


    /**
     * 模糊查询和排序获取商品
     *
     * @param $search
     * @param $order
     * @return Builder[]|Collection
     */
    public function getProductsByQuery($search, $order)
    {
        $builder = Product::query()->where('on_sale', true);
        // 模糊查询参数
        if ($search) {
            $like = '%' . $search . '%';
            $builder->where(function ($query) use ($like) {
                $query->where('title', 'like', $like)
                    ->orWhere('description', 'like', $like)
                    ->orWhereHas('skus', function ($query) use ($like) {
                        $query->where('title', 'like', $like)
                            ->orWhere('description', 'like', $like);
                    });
            });
        }

        // 排序 price 价钱/sold_count 销量/rating 评分__asc|desc
        if ($order) {
            if (preg_match('/^(.+)_(asc|desc)$/', $order, $result)) {
                // 如果字符串的开头是这 3 个字符串之一，说明是一个合法的排序值
                if (in_array($result[1], ['price', 'sold_count', 'rating'])) {
                    $builder->orderBy($result[1], $result[2]);
                }
            }
        }

//        $sql = $builder->toSql(); 打印执行的sql语句
        return $builder->get();
    }

    /**
     * 用户收藏商品
     *
     * @param $user
     * @param $product
     * @return bool
     */
    public function favoriteProduct($user, $product): bool
    {
        if ($user->favoriteProducts()->find($product->id)) {
            return false;
        }
        /** @var User $user */
        $user->favoriteProducts()->attach($product);
        return true;
    }

    /**
     * 用户取消收藏商品
     *
     * @param $userId
     * @param $productId
     * @return int
     */
    public function disFavoriteProduct($user, $product): int
    {
        /** @var User $user */
        return $user->favoriteProducts()->detach($product);
    }
}
