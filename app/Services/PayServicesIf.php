<?php

namespace App\Services;

use App\Models\Installment;
use App\Models\Order;

interface PayServicesIf
{
    public function orderPay($user, $data);
    public function createPayInstallment(Order $order, $user, $count);
    public function installmentOrderPayByAli(Installment $installment);
    public function installmentWechatPay(Installment $installment);
}
