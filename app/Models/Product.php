<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Str;

class Product extends BaseModel
{

    protected $fillable = [
        'title', 'description', 'image', 'on_sale',
        'rating', 'sold_count', 'review_count', 'price'
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
        return $this->hasMany(ProductSku::class);
    }


    public function getImageAttribute()
    {
        // 如果 image 字段本身就已经是完整的 url 就直接返回
        if (Str::startsWith($this->attributes['image'], ['http://', 'https://'])) {
            return $this->attributes['image'];
        }
        return env('APP_URL') . '/storage/admin/' . $this->attributes['image'];
    }
}