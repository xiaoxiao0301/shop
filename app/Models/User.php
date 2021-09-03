<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Tymon\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable implements JWTSubject
{
    use HasFactory, Notifiable, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password', 'user_id', 'phone',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    /**
     * @return mixed
     */
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    /**
     * @return array
     */
    public function getJWTCustomClaims(): array
    {
        return [];
    }

    /**
     * 模型-事件：注册在触发各种模型事件时执行的闭包，而不使用自定义事件类
     *
     * @return void
     */
    protected static function boot()
    {
        parent::boot();
        // 监听模型创建事件，在写入数据库之前触发
        static::creating(function ($model) {
            if (!$model->user_id) {
                $model->user_id = self::generateSnowflakeUserId();
                // 如果生成了重复的user_id则退出
                if (!$model->user_id) {
                    return false;
                }
            }
        });
    }


    /**
     * 利用雪花算法生成user_id
     *
     * @return mixed
     */
    protected static function generateSnowflakeUserId()
    {
        return app('snowflake')->id();
    }

    /**
     * 一对多正向，关联收货地址
     *
     * @return HasMany
     */
    public function addresses(): HasMany
    {
        return $this->hasMany(UserAddress::class, 'user_id', 'user_id');
    }

    /**
     * 多对多，收藏商品
     *
     * @return BelongsToMany
     */
    public function favoriteProducts(): BelongsToMany
    {
        // 第五个字段指定我们在当前模型获取值得字段
        return $this->belongsToMany(
            Product::class,
            'user_favorite_products',
            'user_id',
            'product_id',
        'user_id')->as('u_p')->withTimestamps();
    }


    /**
     * 一对多，购物车
     *
     * @return HasMany
     */
    public function cartItems(): HasMany
    {
        return $this->hasMany(CartItem::class, 'user_id', 'user_id');
    }

}
