<?php

namespace Database\Factories;

use App\Models\Coupon;
use Illuminate\Database\Eloquent\Factories\Factory;

class CouponFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Coupon::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {

        // 首先随机取得一个类型
        $type = $this->faker->randomElement(array_keys(Coupon::$typeMap));
        // 根据取得的类型生成对应折扣
        $value = $type === Coupon::TYPE_FIXED ? random_int(1, 200) : random_int(1, 50);
        // 如果是固定金额，则最低订单金额必须要比优惠金额高 0.01 元
        if ($type == Coupon::TYPE_FIXED) {
            $minAmount = $value + random_int(10, 100);
        } else {
            if (random_int(0, 100) < 50) {
                // 类似无门槛使用
                $minAmount = 0;
            } else {
                $minAmount = random_int(100, 1000);
            }
        }

        return [
            'title' => join(' ', $this->faker->words), // 随机生成名称
            'description' => $this->faker->text,
            'code' => Coupon::generateCouponCode(),
            'type' => $type,
            'value' => $value,
            'total_number' => random_int(10, 50),
            'min_amount' => $minAmount,
            'is_available' => true,
        ];
    }
}
