<?php

namespace App\Services;

interface OrderServicesIf
{
    public function createOrder($user, $data);
    public function orderListsByUser($user);
}
