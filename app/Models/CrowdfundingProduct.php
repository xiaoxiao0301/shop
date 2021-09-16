<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;

/**
 * 众筹表
 *
 * 与普通商品相比，众筹商品有如下特殊的业务逻辑：
    * - 需要设置目标金额与截止时间
    * - 到达截止时间时如果总订单金额低于目标金额则众筹失败，并退款所有订单
    * - 到达截止时间时如果总订单金额大等于目标金额则众筹成功
    * - 众筹订单不支持用户主动申请退款
    * - 在众筹成功之前订单不可发货
 *
 */
class CrowdfundingProduct extends BaseModel
{
    // 定义众筹的 3 种状态
    const STATUS_FUNDING = 'funding';
    const STATUS_SUCCESS = 'success';
    const STATUS_FAIL = 'fail';

    public static $statusMap = [
        self::STATUS_FUNDING => '众筹中',
        self::STATUS_SUCCESS => '众筹成功',
        self::STATUS_FAIL    => '众筹失败',
    ];


    protected $fillable = [
        'target_amount', 'total_amount', 'user_count', 'end_time', 'status'
    ];

    protected $dates = ['end_time'];

    public $timestamps = false;

    /**
     * @return BelongsTo
     */
    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }

    public function getPercentAttribute()
    {
        $value = $this->attributes['total_amount'] / $this->attributes['target_amount'];
        return floatval(number_format($value * 100, 2, '.', ''));
    }
}
