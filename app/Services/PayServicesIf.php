<?php

namespace App\Services;

interface PayServicesIf
{
    public function orderPay($user, $data);
}
