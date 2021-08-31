<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\dict\CouponDict;
use App\Models\CouponCode;
use Faker\Generator as Faker;

$factory->define(CouponCode::class, function (Faker $faker) {

    // 首先随机取得一个类型
    $type  = $faker->randomElement(array_keys(CouponDict::$typeMap));
    // 根据取得的类型生成对应折扣
    $value = $type === CouponDict::TYPE_FIXED ? random_int(1, 200) : random_int(1, 50);
    // 如果是固定金额，则最低订单金额必须要比优惠金额高 0.01 元
    if ($type == CouponDict::TYPE_FIXED) {
        $minAmount = $value + 0.01;
    } else {
        if (random_int(0, 100) < 50) {
            // 类似无门槛使用
            $minAmount = 0;
        } else {
            $minAmount = random_int(100, 1000);
        }
    }

    return [
        'name'       => join(' ', $faker->words), // 随机生成名称
        'code'       => CouponCode::generateCouponCode(),
        'type'       => $type,
        'value'      => $value,
        'total'      => 1000,
        'used'       => 0,
        'min_amount' => $minAmount,
        'not_before' => null,
        'not_after'  => null,
        'enabled'    => true,
    ];
});
