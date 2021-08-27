<?php

namespace App\Services;

interface ProductServicesIf
{
    public function getProducts();
    public function getProductsByQuery($search, $order);
    public function favoriteProduct($user, $product);
    public function disFavoriteProduct($user, $product);
}
