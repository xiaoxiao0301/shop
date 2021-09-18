<?php

namespace App\Models;


use Brick\Math\BigDecimal;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class InstallmentItem extends BaseModel
{
    const REFUND_STATUS_PENDING = 'pending';
    const REFUND_STATUS_PROCESSING = 'processing';
    const REFUND_STATUS_SUCCESS = 'success';
    const REFUND_STATUS_FAILED = 'failed';

    public static $refundStatusMap = [
        self::REFUND_STATUS_PENDING    => '未退款',
        self::REFUND_STATUS_PROCESSING => '退款中',
        self::REFUND_STATUS_SUCCESS    => '退款成功',
        self::REFUND_STATUS_FAILED     => '退款失败',
    ];

    protected $fillable = [
        'sequence',
        'base',
        'fee',
        'fine',
        'due_date',
        'paid_at',
        'payment_method',
        'payment_no',
        'refund_status',
    ];
    protected $dates = ['due_date', 'paid_at'];

    // 添加不属于模型的属性，可以使用访问器在接口中使用
    protected $appends = ['total', 'is_overdue'];

    /**
     * @return BelongsTo
     */
    public function installment(): BelongsTo
    {
        return $this->belongsTo(InstallmentItem::class);
    }

    /**
     * 访问器，返回当前还款计划需要还款的总金额
     *
     * @return string
     */
    public function getTotalAttribute(): string
    {
        // 小数点计算需要用 bcmath 扩展提供的函数
//        $total = bcadd($this->base, $this->fee, 2);
//        if (!is_null($this->fine)) {
//            $total = bcadd($total, $this->fine, 2);
//        }
        // brick/math
        $total = BigDecimal::of($this->base)->plus($this->fee);
        if (!is_null($this->find)) {
            $total = BigDecimal::of($total)->plus($this->fine);
        }
        return $total;
    }

    /**
     * 访问器，返回当前还款计划是否已经过期
     *
     * @return string
     */
    public function getIsOverdueAttribute(): string
    {
        return Carbon::now()->gt($this->due_date) ? '已逾期' : '待还款' ;
    }
}
