<?php

namespace App\Services;

interface OrderServicesIf
{
    public function createOrder($user, $orderData, $coupon = null);
    public function orderLists($user);
    public function orderDetail($order);
}
