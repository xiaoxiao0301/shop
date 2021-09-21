<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProductProperty extends BaseModel
{
    protected $fillable = ['name', 'value'];

    /**
     * @return BelongsTo
     */
    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }
}
