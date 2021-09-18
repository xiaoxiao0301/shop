<?php

namespace App\Services;

use App\Models\Installment;
use App\Models\User;

interface InstallmentServicesIf
{
    public function index(User $user);
    public function detail(Installment $installment);
    public function installmentAliPayNotify();
    public function installmentWechatNotify();
}
