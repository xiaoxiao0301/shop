<?php

namespace App\Http\Requests\Api;


use App\Models\CartItem;
use App\Models\ProductSku;
use Illuminate\Validation\Rule;

class OrderRequest extends BaseFormRequest
{

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        // 输入的地址编号必须是当前用户的
        // 商品必须存在，必须上架，必须有库存，提交的数量必须小于库存

        return [
            'address_id' => [
                'required',
                Rule::exists('user_addresses', 'id')
                    ->where('user_id', $this->user()->user_id)
                    ->whereNull('deleted_at')
            ],
            'items' => ['required', 'array'],
            'items.*.product_sku_id' => [
                'required',
                function($attribute, $value, $fail) {
                    if (!$sku = ProductSku::find($value)) {
                        $fail('商品不存在');
                    }
                    if (!$sku->product->on_sale) {
                        $fail('商品未上架');
                    }
                    if ($sku->stock === 0) {
                        $fail('商品已售罄');
                    }
                    // 购买数量不能大于剩下的库存
                    preg_match('/items\.(\d+)\.product_sku_id/', $attribute, $result);
                    $index = $result[1];
                    $amount = $this->input('items')[$index]['amount'];
                    if ($amount >0 && $amount > $sku->stock) {
                        $fail('商品库存不足');
                    }
                    $isDeleted = CartItem::query()->where('user_id', $this->user()->user_id)
                        ->where('product_sku_id', $value)
                        ->first();
                    if (!$isDeleted) {
                        $fail('非法商品');
                    }
                },

            ],
            'items.*.amount' => ['required', 'integer', 'min:1']
        ];
    }

    public function attributes()
    {
        return [
            'address_id' => '地址信息',
        ];
    }

}
