<?php

namespace App\Services;

interface UserServicesIf
{
    // 注册登陆
    public function getUserInfoFromJwt();
    public function getUserInfoByPhone($phone);
    public function checkLoginCode($data);
    public function saveUser($phone);

    // 收货地址
    public function saveUserAddress($addressData);
    public function updateUserAddress($address, $addressData);
    public function deleteUserAddress($address);
    public function getLoginAddressLists();

    // 商品
    public function addFavoriteProduct($product);
    public function deleteFavoriteProduct($product);
    public function userFavoriteProductLists();

    // 购物车
    public function addProductToCartItem($productSkuId, $amount);
    public function deleteProductFromCartItem($productSkuIds);
    public function getUserCartItemLists();

    // 优惠券
    public function collectShopCoupon($coupon);
    public function couponLists();

    // 消息通知
    public function getNotificationsLists();
    public function readAllNotifications();
}
