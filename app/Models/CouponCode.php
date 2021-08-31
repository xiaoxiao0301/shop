<?php

namespace App\Models;


use App\dict\Codes;
use App\dict\CouponDict;
use App\Exceptions\CouponCodeUnavailableException;
use Carbon\Carbon;
use Str;

class CouponCode extends BaseModel
{
    protected $fillable = [
        'name', 'code', 'type', 'value',
        'total', 'used', 'min_amount', 'not_before', 'not_after', 'enabled',
    ];

    protected $casts = [
        'enabled' => 'boolean',
    ];

    protected $appends = [
        'description'
    ];

    protected $dates = [
        'not_before', 'not_after'
    ];

    /**
     * 生成优惠码
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
     * 模型获取器
     *
     * @return string
     */
    public function getDescriptionAttribute(): string
    {
        $str = '';
        if ($this->min_amount > 0) {
            $str = '满' . str_replace('.00', '', $this->min_amount);
        }
        if ($this->type == CouponDict::TYPE_PERCENT) {
            return  $str . '优惠' . str_replace('.00', '', $this->value) . '%';
        }
        return $str . '减' . str_replace('.00', '', $this->value);
    }

    /**
     * 优惠券校验
     * 规则：
     *   一张优惠券对每一个用户来说只能使用一次
     *   使用： 关联了此优惠券的未付款且未关闭订单或者已付款且未退款订单
     * @param null $orderAmount
     * @throws CouponCodeUnavailableException
     */
    public function checkAvailable(User $user, $orderAmount = null)
    {
        // 优惠券未启用，不存在
        if (!$this->enabled) {
            throw new CouponCodeUnavailableException(
                Codes::CODE_COUPON_CODE_NOT_FOUND,
                '',
                Codes::STATUS_CODE_NOT_FOUND
            );
        }

        // 优惠券已被兑换完毕
        if ($this->total - $this->used <= 0) {
            throw new CouponCodeUnavailableException(
                Codes::CODE_COUPON_CODE_HAS_EXCHANGED,
            '',
                Codes::STATUS_CODE_FORBIDDEN
            );
        }

        // 未到开始使用时间，不能使用
        if ($this->not_before && $this->not_before->gt(Carbon::now())) {
            throw new CouponCodeUnavailableException(Codes::CODE_COUPON_CODE_NOT_START,
                '',
                Codes::STATUS_CODE_FORBIDDEN
            );
        }

        // 该优惠券已过期
        if ($this->not_after && $this->not_after->lt(Carbon::now())) {
            throw new CouponCodeUnavailableException(Codes::CODE_COUPON_CODE_EXPIRED,
                '',
                Codes::STATUS_CODE_FORBIDDEN
            );
        }

        // 金额最小是否满足
        if (!is_null($orderAmount) && $orderAmount < $this->min_amount) {
            throw new CouponCodeUnavailableException(Codes::CODE_ORDER_AMOUNT_NOT_REQUIRED,
                '',
                Codes::STATUS_CODE_FORBIDDEN
            );
        }

        // 判断用户已经是否使用过了
        $used = Order::query()->where('user_id', $user->user_id)
            ->where('coupon_code_id', $this->id)
            ->where(function ($query) {

            })
            ->exists();
        if ($used) {
            throw new CouponCodeUnavailableException(Codes::CODE_COUPON_USER_HAS_USED,
            '',
            Codes::STATUS_CODE_FORBIDDEN
            );
        }

    }


    /**
     * 计算使用优惠券后订单的总金额
     *
     * @param $orderAmount
     * @return mixed|string
     */
    public function calcUsedCouponPrice($orderAmount)
    {
        if ($this->type == CouponDict::TYPE_FIXED) {
            return max(0.04, $orderAmount - $this->value);
        }

        return number_format($orderAmount * (100 - $this->value) / 100, 2, '.', '');
    }


    /**
     * 修改优惠券的使用量与商品sku一致
     *
     * @param bool $increase
     * @return int
     */
    public function changeUsed(bool $increase = true): int
    {
        if ($increase) {
            //检查当前用量是否已经超过总量
            return $this->newQuery()->where('id', $this->id)
                ->where('used', '<', $this->total)
                ->increment('used');
        } else {
            return $this->decrement('used');
        }
    }


}
