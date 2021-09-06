<?php

namespace App\Services;

interface UserServicesIf
{
    public function getUserInfoFromJwt();
    public function getUserInfoByPhone($phone);
    public function checkLoginCode($data);
    public function saveUser($phone);

    public function saveUserAddress($addressData);
    public function updateUserAddress($address, $addressData);
    public function deleteUserAddress($address);
    public function getLoginAddressLists();

    public function addFavoriteProduct($product);
    public function deleteFavoriteProduct($product);
    public function userFavoriteProductLists();

    public function addProductToCartItem($productSkuId, $amount);
    public function deleteProductFromCartItem($productSkuIds);
    public function getUserCartItemLists();

    public function collectShopCoupon($coupon);
    public function couponLists();
}
