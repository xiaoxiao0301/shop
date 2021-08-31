<?php

namespace App\Services\impl;

use App\dict\Codes;
use App\Exceptions\CouponCodeUnavailableException;
use App\Models\CouponCode;
use App\Services\CouponCodeServicesIf;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;

class CouponCodeServiceImpl implements CouponCodeServicesIf
{

    /**
     * 检查优惠码是否可用
     *
     * @param $user
     * @param $code
     * @return CouponCode|Builder|Model|object
     * @throws CouponCodeUnavailableException
     */
    public function checkCouponCodeIsAvailable($user, $code)
    {
        $code = strtoupper($code);
        $couponInfo = CouponCode::query()->where('code', $code)->first();
        if (!$couponInfo) {
            throw new CouponCodeUnavailableException(Codes::CODE_COUPON_CODE_NOT_FOUND, '', Codes::STATUS_CODE_NOT_FOUND);
        }
        /** @var CouponCode $couponInfo */
        $couponInfo->checkAvailable($user);
        return $couponInfo;
    }
}
