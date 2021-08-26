<?php

namespace App\Models;

class UserAddress extends BaseModel
{
    protected $fillable = [
        'province',
        'city',
        'district',
        'address',
        'zip',
        'contact_name',
        'contact_phone',
        'last_used_at',
        'user_id',
    ];

    // 表示 last_used_at 字段是一个时间日期类型，在之后的代码中 $address->last_used_at
    // 返回的就是一个时间日期对象（确切说是 Carbon 对象，Carbon 是 Laravel 默认使用的时间日期处理类）。
    protected $dates = ['last_used_at'];

    /**
     * 模型关联， 一个用户可以有多个收货地址，一个收货地址只能对应一个用户 一对多
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

    /**
     * 模型访问器, $userAddress->full_address 输出完整的地址
     *
     * @return string
     */
    public function getFullAddressAttribute()
    {
        return "{$this->province}{$this->city}{$this->district}{$this->address}";
    }

}
