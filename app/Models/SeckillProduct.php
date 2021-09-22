<?php

namespace App\Models;


use Carbon\Carbon;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SeckillProduct extends BaseModel
{
    protected $fillable = ['start_time', 'end_time'];

    protected $dates = ['start_time', 'end_time'];

    /**
     * @return BelongsTo
     */
    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }

    /**
     * 定义一个名为 is_before_start 的访问器，当前时间早于秒杀开始时间时返回 true
     *
     * @return bool
     */
    public function getIsBeforeStartAttribute(): bool
    {
        return Carbon::now()->lt($this->start_time);
    }

    /**
     * 定义一个名为 is_after_end 的访问器，当前时间晚于秒杀结束时间时返回 true
     *
     * @return bool
     */
    public function getIsAfterEndAttribute(): bool
    {
        return Carbon::now()->gt($this->end_time);
    }
}
