<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;

class UserAddress extends BaseModel
{
    protected $fillable = [
        'province', 'city', 'district', 'address',
        'zip', 'contact_name', 'contact_phone', 'last_used_at',
    ];

    // 表示 last_used_at 字段是一个时间日期类型,
    protected $dates = ['last_used_at'];

    /**
     * 一对多反向,关联用户
     *
     * @return BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

}
