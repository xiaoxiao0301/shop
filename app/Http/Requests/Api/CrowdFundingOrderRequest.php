<?php

namespace App\Http\Requests\Api;

use App\Models\CrowdfundingProduct;
use App\Models\Product;
use App\Models\ProductSku;
use Illuminate\Validation\Rule;

class CrowdFundingOrderRequest extends BaseFormRequest
{
    /**
     *  众筹商品只有众筹成功之后才可以发货；
        众筹订单不支持用户主动申请退款；
        众筹商品不允许使用优惠券购买；
        众筹失败的情况下会退款，如果众筹商品和普通商品混合在一起，处理退款时就需要部分退款，可能需要引入额外的表来记录相关信息。
     */
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'product_sku_id' => [
                'required',
                function($attribute, $value, $fail) {
                    if (!$productSku = ProductSku::find($value)) {
                        return $fail('商品不存在');
                    }
                    if (!$productSku->product->on_sale) {
                        return $fail('商品未上架');
                    }
                    if ($productSku->product->type != Product::TYPE_CROWDFUNDING) {
                        return $fail('商品不支持众筹');
                    }
                    if ($productSku->product->crowdfunding->status !== CrowdfundingProduct::STATUS_FUNDING) {
                        return $fail('商品已众筹结束');
                    }
                    if ($productSku->stock === 0) {
                        return $fail('商品已售完');
                    }
                    if ($this->input('amount') > 0 && $productSku->stock < $this->input('amount')) {
                        return $fail('商品库存不足');
                    }
                    return true;
                },
            ],
            'amount' => ['required', 'integer', 'min:1'],
            'address_id' => [
                'required',
                Rule::exists('user_addresses', 'id')
                    ->where('user_id', $this->user()->user_id)
                    ->whereNull('deleted_at')
            ],
        ];
    }
}
