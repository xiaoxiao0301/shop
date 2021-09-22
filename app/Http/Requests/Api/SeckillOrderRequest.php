<?php

namespace App\Http\Requests\Api;

use App\Dict\RedisCacheKeys;
use App\Models\Order;
use App\Models\ProductSku;
use Auth;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Facades\Redis;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;

class SeckillOrderRequest extends BaseFormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'address.province'      => 'required',
            'address.city'          => 'required',
            'address.district'      => 'required',
            'address.address'       => 'required',
            'address.zip'           => 'required',
            'address.contact_name'  => 'required',
            'address.contact_phone' => 'required',
            'product_sku_id' => [
                'required',
                function($attribute, $value, $fail) {
                    // 从缓存中读取商品的库存
                    $stock = Redis::get(RedisCacheKeys::SECKILL_PRODUCT_STOCK_KEY . $value);
                    if (is_null($stock)) {
                        return $fail('商品不存在');
                    }
                    if ($stock < 1) {
                        return $fail('该商品已售完');
                    }

                    if (!$user = Auth::user()) {
                        throw new AccessDeniedHttpException('请先登陆');
                    }

                    $productSku = ProductSku::find($value);
                    if ($productSku->product->seckill->is_before_start) {
                        return $fail('秒杀暂未开始');
                    }
                    if ($productSku->product->seckill->is_after_end) {
                        return $fail('秒杀已结束');
                    }

                    if ($order = Order::query()
                        ->where('user_id', $user->user_id)
                        ->whereHas('items', function ($query) use ($value) {
                            /** @var Builder $query */
                            $query->where('product_sku_id', $value); // 筛选出包含当前 SKU 的订单
                        })
                        ->where(function ($query) {
                            /** @var Builder $query */
                            $query->whereNotNull('paid_at') // 已支付的订单
                                ->orWhere('closed', false); // 或者未关闭的订单
                        })
                        ->first()) {
                        if ($order->paid_at) {
                            return $fail('你已经抢购了该商品');
                        }
                        return $fail('你已经下单了该商品，请到订单页面支付');
                    }

                    return true;
                },
            ],
        ];
    }
}
