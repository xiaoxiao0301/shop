<?php

namespace App\Services;

interface OrderServicesIf
{
    public function createOrder($user, $data);
    public function orderListsByUser($user);
    public function orderPaymentByAli($order);
    public function orderPaymentByWechat($order);
    public function updateOrderShipStatus($order);
    public function getOrderReviewInfo($order);
    public function saveOrderReview($order, $data);
}
