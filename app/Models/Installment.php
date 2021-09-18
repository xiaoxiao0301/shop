<?php

namespace App\Models;


use Exception;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Log;

class Installment extends BaseModel
{
    const STATUS_PENDING = 'pending';
    const STATUS_REPAYING = 'repaying';
    const STATUS_FINISHED = 'finished';

    public static $statusMap = [
        self::STATUS_PENDING  => '未执行',
        self::STATUS_REPAYING => '还款中',
        self::STATUS_FINISHED => '已完成',
    ];

    protected $fillable = ['no', 'total_amount', 'count', 'fee_rate', 'fine_rate', 'status'];

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($model) {
            // 如果模型的 no 字段为空
            if (!$model->no) {
                // 调用 findAvailableNo 生成分期流水号
                $model->no = self::findAvailableNo();
                // 如果生成失败，则终止创建订单
                if (!$model->no) {
                    return false;
                }
            }
            return true;
        });
    }

    /**
     * @return BelongsTo
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

    /**
     * @return BelongsTo
     */
    public function order(): BelongsTo
    {
        return $this->belongsTo(Order::class, 'order_id', 'order_no');
    }

    /**
     * @return HasMany
     */
    public function items(): HasMany
    {
        return $this->hasMany(InstallmentItem::class);
    }

    /**
     * 生成分期流水号
     *
     * @return false|string
     * @throws Exception
     */
    public static function findAvailableNo()
    {
        // 分期流水号前缀
        $prefix = date('YmdHis');
        for ($i = 0; $i < 10; $i++) {
            // 随机生成 6 位的数字
            $no = $prefix.str_pad(random_int(0, 999999), 6, '0', STR_PAD_LEFT);
            // 判断是否已经存在
            if (!static::query()->where('no', $no)->exists()) {
                return $no;
            }
        }
        Log::warning('find installment no failed');

        return false;
    }

    public function refreshRefundStatus()
    {
        // 表示退款成功
        $allSuccess = true;
        $this->load(['items']);
        foreach ($this->items as $installItem) {
            // 如果该还款计划已经还款，但退款状态不是成功
            if ($installItem->paid_at && $installItem->refund_status !== InstallmentItem::REFUND_STATUS_SUCCESS) {
                $allSuccess = false;
                break;
            }
        }
        // 如果所有退款都成功，则将对应商品订单的退款状态修改为退款成功
        if ($allSuccess) {
            $this->order->update([
                'refund_status' => Order::REFUND_STATUS_SUCCESS,
            ]);
        }
    }

}
