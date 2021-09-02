<?php

namespace App\Services;

interface ProductServicesIf
{
    public function getProductLists($search = null, $order = null);
    public function getProductDetail($product);
}
