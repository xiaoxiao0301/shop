<?php

namespace App\Services\impl;

use App\Dict\RedisCacheKeys;
use App\Dict\ResponseJsonData;
use App\Events\OrderPaid;
use App\Events\OrderReviewed;
use App\Exceptions\InvalidRequestException;
use App\Jobs\RefundInstallmentOrder;
use App\Models\Coupon;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\ProductSku;
use App\Models\User;
use App\Models\UserAddress;
use App\Services\OrderServicesIf;
use Carbon\Carbon;
use DB;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Redis;
use Log;
use Throwable;

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
                'type' => Order::TYPE_NORMAL,
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
        $this->addUnPayOrderToRedisList($order, RedisCacheKeys::ORDER_PAY_LIMIT_SEC, $couponId);
        return ResponseJsonData::responseOk($order->toArray());
    }


    /**
     * 创建众筹订单
     *
     * @param User $user
     * @param UserAddress $address
     * @param ProductSku $productSku
     * @param $amount
     * @return JsonResponse
     * @throws Throwable
     */
    public function createCrowdfundingOrder(User $user, UserAddress $address, ProductSku $productSku, $amount)
    {
        DB::beginTransaction();
        try {
            // 更新地址最后使用时间
            $address->update(['last_used_at' => Carbon::now()]);
            $order = Order::create([
                'address' => [
                    'address' => $address->full_address,
                    'zip' => $address->zip,
                    'contact_name' => $address->contact_name,
                    'contact_phone' => $address->contact_phone,
                ],
                'remark' => '',
                'total_amount' => $productSku->price * $amount,
                'type' => Order::TYPE_CROWDFUNDING,
            ]);
//             订单关联用户
            $order->user()->associate($user);
            $order->save();
            // 订单详情 OrderItem
            $orderItem = $order->items()->make([
                'amount' => $amount,
                'price' => $productSku->price,
            ]);
            $orderItem->product()->associate($productSku->product_id);
            $orderItem->productSku()->associate($productSku);
            $orderItem->save();
            // 减库存
            if ($productSku->decreaseStock($amount) <= 0) {
                throw new InvalidRequestException('商品库存不足');
            }
            DB::commit();
        } catch (InvalidRequestException $exception) {
            DB::rollBack();
            return ResponseJsonData::responseUnProcessAble($exception->getMessage());
        }
        // 将众筹订单也放入队列中去处理
        $orderLimitAtSec = $productSku->product->crowdfunding->end_time->getTimestamp() - time();
        $this->addUnPayOrderToRedisList($order, $orderLimitAtSec);
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
     * 支付宝网站前端回调
     *
     * @return JsonResponse
     */
    public function aliPayReturn()
    {
        Log::debug('AliPay Return', app('alipay')->callback()->toArray());
        try {
            app('alipay')->callback();
        } catch (Exception $exception) {
            Log::error('支付宝前端回调异常', ['msg' => $exception->getMessage()]);
            return ResponseJsonData::responseInternal();
        }
        return ResponseJsonData::responseOk();
    }

    /**
     * 普通订单支付宝回调
     *
     * @return string
     */
    public function aliPayNotify()
    {
        Log::debug('AliPay Notify', app('alipay')->callback()->toArray());
        $data = app('alipay')->callback();
        /** @var Order $order */
        $order = Order::query()->where('order_no', $data->out_trade_no)->first();
        if (!$order) {
            return 'fail';
        }
        if ($order->paid_at) {
            return app('alipay')->success();
        }
        $order->update([
            'paid_at'        => Carbon::now(), // 支付时间
            'payment_method' => 'alipay', // 支付方式
            'payment_no'     => $data->trade_no, // 支付宝订单号
        ]);

        $this->updateProductSoldCount($order);

        return app('alipay')->success();
    }

    /**
     * 普通订单微信支付回调
     *
     * @return string
     */
    public function wechatPayNotify()
    {
        $data = app('wechat')->callback();
        /** @var Order $order */
        $order = Order::query()->where('order_no', $data->out_trade_no)->first();
        if (!$order) {
            return 'fail';
        }
        if ($order->paid_at) {
            return app('wechat')->success();
        }
        $order->update([
            'paid_at'        => Carbon::now(), // 支付时间
            'payment_method' => 'wechat', // 支付方式
            'payment_no'     => $data->transaction_id, // 微信订单号
        ]);

        $this->updateProductSoldCount($order);

        return app('wechat')->success();
    }

    /**
     * 确认收货
     *
     * @param $order
     * @throws InvalidRequestException
     */
    public function receivedOrder($order)
    {
        if (!$order->paid_at) {
            throw new InvalidRequestException('订单未支付不能收货');
        }
        if (!$order->ship_status == Order::SHIP_STATUS_DELIVERED) {
            throw new InvalidRequestException('订单未发货');
        }
        $order->update([
            'ship_status' => Order::SHIP_STATUS_RECEIVED
        ]);
    }

    /**
     * 订单评价
     *
     * @param Order $order
     * @param $data
     * @return JsonResponse
     * @throws InvalidRequestException
     * @throws Throwable
     */
    public function reviewOrder(Order $order, $data)
    {
        /**
         * 1. 订单必须是已收货才能评价
         * 2. 订单当然必须是支付完成的哈
         */
        if (!$order->paid_at) {
            throw new InvalidRequestException('订单未支付，不可评价');
        }

        if ($order->reviewed) {
            throw new InvalidRequestException('订单已评价，不可重复评价');
        }

        DB::transaction(function () use ($order, $data) {
            foreach ($data as $review) {
                $orderItem = $order->items()->find($review['id']);
                $orderItem->update([
                    'rating' => $review['rating'],
                    'review' => $review['review'],
                    'reviewed_at' => Carbon::now(),
                ]);
            }

            $order->update(['reviewed' => true]);

            event(new OrderReviewed($order));
        });

        return ResponseJsonData::responseOk();

    }

    /**
     * 订单列表页面的评价详情
     *
     * @param Order $order
     * @return array
     * @throws InvalidRequestException
     */
    public function orderReviewDetail(Order $order)
    {
        if (!$order->reviewed) {
            throw new InvalidRequestException('订单尚未评价');
        }
        return $order->items()->with('product')->get()->toArray();
    }

    /**
     * 申请退款
     *
     * @param $order
     * @param $reason
     * @throws InvalidRequestException
     */
    public function applyOrderRefund($order, $reason)
    {
        if (!$order->paid_at) {
            throw new InvalidRequestException('订单未支付，不能发起退款');
        }

        if ($order->type === Order::TYPE_CROWDFUNDING) {
            throw new InvalidRequestException('众筹订单不支持退款');
        }

        if ($order->refund_status != Order::REFUND_STATUS_PENDING) {
            throw new InvalidRequestException('已发起退款，请稍后...');
        }

        $extra = $order->extra ?: [];
        $extra['refund_reason'] = $reason;

        $order->update([
            'refund_status' => Order::REFUND_STATUS_APPLIED,
            'extra' => $extra
        ]);
    }

    /**
     * 退款，支付宝/微信
     * @param Order $order
     */
    public function refundOrder(Order $order)
    {
        Log::debug('正在进行退款的订单信息:', $order->toArray());
        switch ($order->payment_method) {
            case 'wechat':
                $refundNo = Order::generateOrderRefundStringNumber();
                $refundData = [
                    'out_trade_no' => $order->order_no,
                    'out_refund_no' => $refundNo,
                    'amount' => [
                        'refund' => $order->total_amount * 100,
                        'total' => $order->total_amount * 100,
                        'currency' => 'CNY',
                    ],
                ];
                // 微信退款是异步的哈, v3版本待测试
                app('wechat')->refund($refundData);
                $order->refund_no = $refundNo;
                $order->refund_status = Order::REFUND_STATUS_PROCESSING;
                $order->save();
                break;
            case 'alipay':
                $result = app('alipay')->refund([
                    'out_trade_no' => $order->order_no,
                    'refund_amount' => $order->total_amount,
                ]);
                Log::debug('支付宝退款回调参数:', $result->toArray());
                if ($result->sub_code) {
                    // 退款失败
                    $extra = $order->extra;
                    $extra['refund_failed_code'] = $result->sub_code;
                    $order->refund_status = Order::REFUND_STATUS_FAILED;
                    $order->extra = $extra;
                    $order->save();
                } else {
                    // 退款成功
                    $order->refund_no = $result->trade_no;
                    $order->refund_status = Order::REFUND_STATUS_SUCCESS;
                    $order->save();
                }
                break;
            case 'installment':
                $order->update([
                    'refund_no' => Order::generateOrderRefundStringNumber(), // 生成退款订单号
                    'refund_status' => Order::REFUND_STATUS_PROCESSING, // 将退款状态改为退款中
                ]);
                dispatch(new RefundInstallmentOrder($order));
                break;
            default:
                throw new InvalidRequestException('未知订单支付方式:'. $order->payment_method);
        }
    }


    /**
     * 将未支付订单添加到未支付订单列表中，定时任务去获取列表数据然后关闭订单
     *
     * @param Order $order
     * @param $orderLimitAtSec
     * @param null $couponId
     */
    protected function addUnPayOrderToRedisList(Order $order, $orderLimitAtSec, $couponId = null)
    {
        $value = json_encode([
            'order_created_at' => $order->created_at->toDateTimeString(),
            'limit_end_time_sec' => $orderLimitAtSec,
            'coupon_id' => $couponId,
        ]);
        Redis::Hset(RedisCacheKeys::ORDER_NOT_PAY_LIST_KEY,  $order->order_no, $value);
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
            if (Carbon::parse($item['order_created_at'])->addSeconds($item['limit_end_time_sec'])->lt(Carbon::now())) {
                $this->handleCloseOrder($orderNo, $item['coupon_id']);
            }
        }
    }

    /**
     * 处理关闭订单逻辑
     *
     * @param $orderNo
     * @param null $couponId
     * @throws Throwable
     */
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
     * 订单支付后，更新订单的销量,发消息通知订单支付成功了
     *
     * @param Order $order
     */
    protected function updateProductSoldCount(Order $order)
    {
        // 从未支付订单中删除
        Redis::Hdel(RedisCacheKeys::ORDER_NOT_PAY_LIST_KEY, $order->order_no);
        event(new OrderPaid($order));
    }

}
