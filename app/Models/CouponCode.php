<?php

namespace App\Models;


use App\dict\CouponDict;
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

    public function getDescriptionAttribute()
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
}
