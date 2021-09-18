<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Str;

class Product extends BaseModel
{
    const TYPE_NORMAL = 'normal';
    const TYPE_CROWDFUNDING = 'crowdfunding';

    public static $typeMap = [
        self::TYPE_NORMAL => '普通商品',
        self::TYPE_CROWDFUNDING => '众筹商品',
    ];

    protected $fillable = [
        'title', 'description', 'image', 'on_sale',
        'rating', 'sold_count', 'review_count', 'price', 'type'
    ];

    protected $casts = [
        'on_sale' => 'boolean'
    ];


    /**
     * 商品和商品sku表，一对多关系
     *
     * @return HasMany
     */
    public function skus(): HasMany
    {
        return $this->hasMany(ProductSku::class, 'product_id');
    }

    public function getImageAttribute()
    {
        // 如果 image 字段本身就已经是完整的 url 就直接返回
        if (Str::startsWith($this->attributes['image'], ['http://', 'https://'])) {
            return $this->attributes['image'];
        }
        return env('APP_URL') . '/storage/admin/' . $this->attributes['image'];
    }

    /**
     * 关联商品类目
     *
     * @return BelongsTo
     */
    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    /**
     * 众筹商品关联， 一对一
     *
     * @return HasOne
     */
    public function crowdfunding(): HasOne
    {
        return $this->hasOne(CrowdfundingProduct::class);
    }
}
