<?php

namespace App\Services;

use App\Models\Order;

interface OrderServicesIf
{
    public function createOrder($user, $orderData, $coupon = null);
    public function orderLists($user);
    public function orderDetail($order);
    public function receivedOrder($order);
    public function reviewOrder(Order $order, $data);
    public function orderReviewDetail(Order $order);
    public function applyOrderRefund($order, $reason);
}
