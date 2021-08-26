<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProductSku extends BaseModel
{
    protected $fillable = [
        'title', 'description', 'price', 'stock'
    ];

    /**
     * 一个商品sku属于一个商品
     *
     * @return BelongsTo
     */
    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }
}
