<?php

namespace App\Models;

use App\Exceptions\InternalException;
use App\Exceptions\InvalidRequestException;
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


    /**
     * 添加库存
     *
     * @param $amount
     * @return int
     * @throws InternalException
     */
    public function addStock($amount)
    {
        if ($amount < 0) {
            throw new InternalException('加库存不可小于0');
        }
        return $this->increment('stock', $amount);
    }


    /**
     * 减库存
     *
     * @param $amount
     * @return int
     * @throws InternalException
     */
    public function decreaseStock($amount)
    {
        if ($amount < 0) {
            throw new InternalException('减库存不可小于0');
        }
        return $this->newQuery()->where('id', $this->id)->where('stock', '>=', $amount)->decrement('stock', $amount);
    }

}

