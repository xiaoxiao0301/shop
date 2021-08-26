<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\HasMany;

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
}
