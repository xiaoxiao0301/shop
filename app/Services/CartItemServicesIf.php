<?php

namespace App\Services;

interface CartItemServicesIf
{
    public function addProductToCart($user, $skuId, $amount);
    public function getCartLists($user);
    public function removeProductFromCart($user, $skuId);
}
