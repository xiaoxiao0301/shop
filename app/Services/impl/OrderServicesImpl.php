<?php

namespace App\Services\impl;

use App\Dict\RedisCacheKeys;
use App\Dict\ResponseJsonData;
use App\Exceptions\InvalidRequestException;
use App\Models\Coupon;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\ProductSku;
use App\Models\User;
use App\Models\UserAddress;
use App\Services\OrderServicesIf;
use Carbon\Carbon;
use DB;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Redis;

class OrderServicesImpl implements OrderServicesIf
{
    /**
     * 创建订单
     *
     *   1.使用了优惠券， 需要检查优惠券的使用时间，是否启用，订单金额是否满足优惠券的规则
     *   2. 更新用户选择地址的最后使用时间，这个可以做常有地址选项
     *   3. 生成订单： 购物车删除记录，商品sku减库存，在有优惠券的情况下，增加优惠券使用量，将优惠券已订单绑定，
     *
     * @param $user
     * @param $orderData
     * @param null $coupon
     */
    public function createOrder($user, $orderData, $coupon = null)
    {
        DB::beginTransaction();

        try {
            // 先对优惠券时间，有效性进行校验不包括订单金额
            if (!is_null($coupon)) {
                /** @var Coupon $coupon */
                $coupon->checkCouponIsAvailable($user);
            }
            // 更新用户收货地址最新使用时间
            $addressInfo = UserAddress::find($orderData['address_id']);
            $addressInfo->update(['last_used_at' => Carbon::now()]);

            // 生成订单信息
            $order = new Order([
                'address' => [
                    'address' => $addressInfo->full_address,
                    'zip' => $addressInfo->zip,
                    'contact_name' => $addressInfo->contact_name,
                    'contact_phone' => $addressInfo->contact_phone,
                ],
                'remark' => $orderData['remark'],
                'total_amount' => 0,
            ]);
            $order->user()->associate($user);
            $order->save();

            // 计算订单总金额
            $orderTotalAmount = 0;
            foreach ($orderData['items'] as $item) {
                /** @var ProductSku $productSku */
                $productSku = ProductSku::find($item['product_sku_id']);
                // 生成订单item
                $orderItem = $order->items()->make([
                    'amount' => $item['amount'],
                    'price' => $productSku->price,
                ]);
                /** @var OrderItem $orderItem */
                $orderItem->product()->associate($productSku->product_id);
                $orderItem->productSku()->associate($productSku);
                $orderItem->save();
                $orderTotalAmount += $item['amount'] * $productSku->price;
                // 商品减少库存
                if ($productSku->decreaseStock($item['amount']) <= 0) {
                    throw new InvalidRequestException('商品库存不足');
                }
            }

            // 有无优惠券重新计算总金额
            if ($coupon) {
                // 再一次检查优惠券，包括金额是否满足规则
                $coupon->checkCouponIsAvailable($user, $orderTotalAmount);
                $orderTotalAmount = $coupon->calcUserUsedCouponOrderTotalAmount($orderTotalAmount);
                // 将订单与优惠券关联
                /** @var User $user */
                $user->coupons()->where('coupon_id', $coupon->id)->update([
                    'used'=> true,
                    'order_id' => $order->order_no
                ]);
                // 更新优惠券的使用量
                $coupon->updateCouponUsedNumber();
            }

            // 更新订单总金额
            $order->total_amount = $orderTotalAmount;
            $order->save();

            // 从购物车移除物品
            $skuIds = collect($orderData['items'])->pluck('product_sku_id');
            $user->cartItems()->whereIn('product_sku_id', $skuIds)->delete();

            DB::commit();

        } catch (InvalidRequestException $exception) {
            DB::rollBack();
            return ResponseJsonData::responseUnProcessAble($exception->getMessage());
        }
        $couponId = $coupon ? $coupon->id : null;
        $this->addUnPayOrderToRedisList($order, $couponId);
        return ResponseJsonData::responseOk($order->toArray());
    }

    /**
     * 订单列表
     *
     * @param $user
     * @return mixed
     */
    public function orderLists($user)
    {
        return $user->orders->load(['items.product', 'items.productSku'])->toArray();
    }

    /**
     * 订单详情
     *
     * @param $order
     * @return JsonResponse
     */
    public function orderDetail($order): JsonResponse
    {
        return ResponseJsonData::responseOk($order->load(['items.product', 'items.productSku'])->toArray());
    }

    /**
     * 将未支付订单添加到未支付订单列表中，定时任务去获取列表数据然后关闭订单
     *
     * @param Order $order
     */
    protected function addUnPayOrderToRedisList(Order $order, $couponId = null)
    {
        $value = json_encode([
            'created_at' => $order->created_at->toDateTimeString(),
            'coupon_id' => $couponId
        ]);
        Redis::Hset(RedisCacheKeys::ORDER_NOT_PAY_LIST_KEY,  $order->order_no, $value);
    }

    /**
     * 从定时任务列表删除已支付订单编号
     *
     * @param Order $order
     */
    protected function removeUnPayOrderFromRedisLists(Order $order)
    {
        Redis::Hdel(RedisCacheKeys::ORDER_NOT_PAY_LIST_KEY, $order->order_no);
    }

    /**
     * 关闭未支付订单
     */
    public function closeNotPayOrder()
    {
        $orderLists = Redis::HgetAll(RedisCacheKeys::ORDER_NOT_PAY_LIST_KEY);
        foreach ($orderLists as $orderNo => $item) {
            $item = json_decode($item, true);
            // 超时未支付的订单需要关闭，这里默认是30分钟未支付
            if (Carbon::parse($item['created_at'])->addSeconds(RedisCacheKeys::ORDER_PAY_LIMIT_SEC)->lt(Carbon::now())) {
                $this->handleCloseOrder($orderNo, $item['coupon_id']);
            }
        }
    }


    protected function handleCloseOrder($orderNo, $couponId = null)
    {
        /** @var Order $order */
        $order = Order::query()->where('order_no', $orderNo)->first();
        if ($order->paid_at) {
            // 定时执行中发现订单已经被删除，还没来得及调用移除方法
            $this->removeUnPayOrderFromRedisLists($order);
        } else {
            /**
             * 1. 将订单设置为关闭状态
             * 2. 将商品的库存追加回去
             * 3. 修改用户优惠券的状态， 包括优惠券的使用量
             */
            DB::transaction(function ()  use ($order, $couponId) {
                $order->update(['closed' => true]);
                foreach ($order->items as $sku) {
                    $sku->productSku->addStock($sku->amount);
                }
                if (!is_null($couponId)) {
                    $user = User::query()->where('user_id', $order->user_id)->first();
                    /** @var User $user */
                    $user->coupons()->where('coupon_id', $couponId)
                        ->update([
                            'used'=> false,
                            'order_id' => null
                        ]);
                    Coupon::query()->where('id', $couponId)->decrement('used_number', 1);
                }
            });
            $this->removeUnPayOrderFromRedisLists($order);
        }
    }
}
