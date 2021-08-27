<?php

namespace App\Services\impl;

use App\Models\CartItem;
use App\Models\User;
use App\Services\CartItemServicesIf;

class CartItemServiceImpl implements CartItemServicesIf
{

    /**
     * 添加商品到购物车
     *
     * @param $user
     * @param $skuId
     * @param $amount
     * @return bool|int
     */
    public function addProductToCart($user, $skuId, $amount)
    {
        /**
         * 1. 判断购物车中是否已有同名的商品
         * 2. 有就累加数量
         * 3. 没有就新建
         */
        /** @var User $user */
        $cart = $user->carItems()->where('product_sku_id', $skuId)->first();
        if ($cart) {
            return $cart->increment('amount', $amount);
        } else {
            $cart = new CartItem(['amount' =>$amount]);
            $cart->user()->associate($user);
            $cart->productSku()->associate($skuId);
            return $cart->save();
        }
    }

    /**
     * 获取用户购物车列表
     *
     * @param $user
     * @return array
     */
    public function getCartLists($user): array
    {
        /** @var User $user */
        return $user->carItems()->with(['productSku.product'])->get()->toArray();
    }


    /**
     * 从购物车中移除商品
     *
     * @param $user
     * @param $sku
     * @return mixed
     */
    public function removeProductFromCart($user, $sku)
    {
        /** @var User $user */
        return $user->carItems()->where('product_sku_id', $sku->id)->delete();
    }
}
