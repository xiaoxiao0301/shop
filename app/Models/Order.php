<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Order extends BaseModel
{
    protected $fillable = [
        'order_no', 'address', 'total_amount', 'remark', 'paid_at', 'payment_method',
        'payment_no', 'refund_status', 'refund_no', 'closed', 'reviewed', 'ship_status', 'ship_data', 'extra',
    ];

    protected $casts = [
        'closed'    => 'boolean',
        'reviewed'  => 'boolean',
        'address'   => 'json',
        'ship_data' => 'json',
        'extra'     => 'json',
    ];

    protected $dates = [
        'paid_at',
    ];


    /**
     * 注册了一个模型创建事件监听函数
     */
    protected static function boot()
    {
        parent::boot();
        // 监听模型创建事件，在写入数据库之前触发
        static::creating(function ($model) {
            if (!$model->order_no) {
                $model->order_no = self::generateOrderNo();
                // 如果生成失败，则终止创建订单
                if (!$model->no) {
                    return false;
                }
            }
            return true;
        });
    }

    /**
     * 模型关联，用户表
     *
     * @return BelongsTo
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

    /**
     * 模型关联，orderItem
     *
     * @return HasMany
     */
    public function items(): HasMany
    {
        return $this->hasMany(OrderItem::class, 'order_id', 'order_no');
    }

    /**
     * 生成订单编号,雪花算法
     *
     * @return mixed
     */
    public static function generateOrderNo()
    {
        $snowFlake = app('snowflake');
        return $snowFlake->id();
    }

}
