<?php

namespace App\Models;


use Str;

class Coupon extends BaseModel
{
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
    public static function generateCouponCode($length = 15): string
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
}
