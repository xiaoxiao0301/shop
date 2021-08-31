<?php

namespace App\Services;

interface CouponCodeServicesIf
{
    public function checkCouponCodeIsAvailable($user, $code);
}
