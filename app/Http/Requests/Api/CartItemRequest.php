<?php

namespace App\Http\Requests\Api;


use App\Models\ProductSku;

class CartItemRequest extends BaseFormRequest
{

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'sku_id' => [
                'required',
                function($attribute, $value, $fail) {
                    if (!$sku = ProductSku::query()->find($value)) {
                        $fail('商品不存在');
                    }
                    if (!$sku->product->on_sale) {
                        $fail('商品已下架');
                    }
                    if ($sku->stock == 0) {
                        $fail('商品已售罄');
                    }
                    if ($this->input('amount')  > 0 && $sku->stock < $this->input('amount')) {
                        $fail('商品库存不足');
                    }
                },
            ],
            'amount' => 'required|integer|min:1'
        ];
    }

    public function attributes()
    {
        return [
            'sku_id' => '商品sku编号',
            'amount' => '商品数量',
        ];
    }
}
