<?php

namespace App\Services\impl;

use App\Models\Coupon;
use App\Services\CouponServicesIf;

class CouponServicesImpl implements CouponServicesIf
{

    /**
     * 根据店铺ID获取店铺优惠券
     *
     * @param $shopId
     * @return array
     */
    public function getCouponsListByShopId($shopId): array
    {
       return Coupon::query()
            ->where('shop_id', $shopId)
            ->where('is_available', true)
            ->get()
            ->toArray();
    }
}
