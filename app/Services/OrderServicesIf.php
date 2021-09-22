<?php

namespace App\Services;

use App\Models\Order;
use App\Models\ProductSku;
use App\Models\User;
use App\Models\UserAddress;

interface OrderServicesIf
{
    public function createOrder($user, $orderData, $coupon = null);
    public function orderLists($user);
    public function orderDetail($order);

    public function aliPayReturn();
    public function aliPayNotify();
    public function wechatPayNotify();

    public function receivedOrder($order);
    public function reviewOrder(Order $order, $data);
    public function orderReviewDetail(Order $order);

    public function applyOrderRefund($order, $reason);

    public function createCrowdfundingOrder(User $user, UserAddress $address, ProductSku $productSku, $amount);

    public function createSeckillOrder(User $user, array $addressData, ProductSku $productSku);

    public function refundOrder(Order $order);
}
