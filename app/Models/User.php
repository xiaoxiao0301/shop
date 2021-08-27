<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Tymon\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable implements JWTSubject
{
    use Notifiable, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password', 'phone', 'user_id',
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
     * 模型关系， 用户关联用户收货地址， 一对多
     *
     * @return HasMany
     */
    public function addresses(): HasMany
    {
        return $this->hasMany(UserAddress::class, 'user_id', 'user_id');
    }


    /**
     * 权限校验
     *
     * @param Model $model
     * @return bool
     */
    public function isAuthOf(Model $model): bool
    {
        return $this->user_id == $model->user_id;
    }


    /**
     * 模型关系，用户收藏商品，多对多
     *
     * @return BelongsToMany
     */
    public function favoriteProducts(): BelongsToMany
    {
        // 多对多, 第三个参数是当前模型的外键
        return $this->belongsToMany(Product::class, 'user_favorite_products', 'user_id', 'product_id')
            ->withTimestamps()
            ->orderBy('user_favorite_products.created_at', 'desc');
    }
}
