<?php

namespace App\Services;

interface ProductServicesIf
{
    public function getProductListsByShopId($search = null, $order = null, $category = null, $shopId = null);
    public function getProductDetail($product);
}
