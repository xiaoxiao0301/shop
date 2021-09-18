<?php

namespace App\Models;


use App\Exceptions\InvalidRequestException;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\SoftDeletes;
use Str;

class Coupon extends BaseModel
{
    use SoftDeletes;

    const TYPE_FIXED = 'fixed';
    const TYPE_PERCENT = 'percent';

    public static $typeMap = [
        self::TYPE_FIXED => '固定值',
        self::TYPE_PERCENT => '百分比',
    ];


    protected $fillable = [
        'title', 'description', 'code', 'total_number', 'type', 'value', 'min_amount',
    ];

    protected $casts = [
        'is_available' => 'boolean'
    ];

    protected $dates = [
        'start_time', 'end_time'
    ];

    protected $appends = ['read'];

    /**
     * 生成优惠券code
     *
     * @param int $length
     * @return string
     */
    public static function generateCouponCode(int $length = 15): string
    {
        do {
            $code = strtoupper(Str::random($length));
        } while(self::query()->where('code', $code)->exists());

        return $code;
    }


    /**
     * 格式化输出便于阅读
     *
     * @return string
     */
    public function getReadAttribute(): string
    {
        $str = '';
        if ($this->min_amount > 0) {
            $str = '满' . str_replace('.00', '', $this->min_amount);
        }
        if ($this->type == self::TYPE_PERCENT) {
            return  $str . '优惠' . str_replace('.00', '', $this->value) . '%';
        }
        return $str . '减' . str_replace('.00', '', $this->value);
    }

    /**
     * 优惠券校验
     *
     * @param User $user
     * @param $amount
     * @throws InvalidRequestException
     */
    public function checkCouponIsAvailable(User $user, $amount = null)
    {
        $notTime = Carbon::now();
        /**
         * 1. 优惠券不能被使用
         * 2. 当前优惠券不能被订单绑定， 取消了订单之后优惠券才能解绑
         * 3. 优惠券在使用期内
         * 4. 金额最小是否满足
         */
        if (!$this->is_available) {
            throw new InvalidRequestException('优惠券不存在');
        }
        if ($this->start_time->gt($notTime)) {
            throw new InvalidRequestException('优惠券无法使用');
        }
        if ($this->end_time->lt($notTime)) {
            throw new InvalidRequestException('优惠券已过期');
        }

        if (!is_null($amount) && $amount < $this->min_amount) {
            throw new InvalidRequestException('不满足优惠券使用规则');
        }


        $used = $user->coupons()->where('coupon_id', $this->id)
            ->where('used', true)
            ->exists();
        if ($used) {
            throw new InvalidRequestException('优惠券已被其他订单使用');
        }
    }

    /**
     * 计算使用了优惠券后用户的订单总金额
     *
     * @param $orderAmount
     * @return mixed|string
     */
    public function calcUserUsedCouponOrderTotalAmount($orderAmount)
    {
        if ($this->type == self::TYPE_FIXED) {
            // 固定金额
            return max(0.04, $orderAmount - $this->value);
        }

        return number_format($orderAmount * (100 - $this->value) / 100, 2, '.', '');
    }

    /**
     * 用户领取优惠券更新已领取数量
     *
     * @return false|int
     */
    public function updateCouponGotNumber()
    {
        return $this->increment('got_number');
    }

    /**
     * 用户下单更新优惠券使用
     *
     * @return false|int
     */
    public function updateCouponUsedNumber()
    {
        return $this->increment('used_number');
    }

    /**
     * 用户取消订单减少优惠券使用量
     *
     * @return false|int
     */
    public function decrementCouponUsedNumber()
    {
        return $this->decrement('used_number');
    }
}
