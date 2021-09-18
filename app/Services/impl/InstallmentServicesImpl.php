<?php

namespace App\Services\impl;

use App\Dict\ResponseJsonData;
use App\Events\OrderPaid;
use App\Models\Installment;
use App\Models\User;
use App\Services\InstallmentServicesIf;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Log;

class InstallmentServicesImpl implements InstallmentServicesIf
{
    /**
     * 分期付款列表
     *
     * @param User $user
     * @return array
     */
    public function index(User $user): array
    {
        return Installment::query()->where('user_id', $user->user_id)->get()->toArray();
    }

    /**
     * 分期付款详情
     *
     * @param Installment $installment
     * @return JsonResponse
     */
    public function detail(Installment $installment): JsonResponse
    {
        $items = $installment->items()->orderBy('sequence')->get();
        $nextItem = $items->whereNull('paid_at')->first();
        $result = [
            'installment' => $installment,
            'items' => $items,
            'nextItem' => $nextItem,
        ];
        return ResponseJsonData::responseOk($result);
    }

    /**
     * 分期付款支付宝回调
     *
     * @return string
     */
    public function installmentAliPayNotify(): string
    {
        /**
         * 1. 逻辑性判断， 分期订单要存在，回款计划要存在
         * 2. 需要对支付的分期进行判断：
         *  1）第一期，
         *      需要将订单改为已支付，然后调用事件触发订单支付事件
         *      修改还款分期的状态为还款中
         *  2）最后一期：
         *      将还款分期的状态改为还款成功
         * 3. 更新还款详情中对应还款那一期的支付时间，支付订单流水号，支付方式
         *
         */
        Log::debug('Installment AliPay Notify', app('alipay')->callback()->toArray());
        $data = app('alipay')->callback();
        if ($this->paid($data->out_trade_no, 'alipay', $data->trade_no)) {
            return app('alipay')->success();
        }
        return 'fail';

    }


    /**
     * 分期付款微信支付回调
     *
     * @return string
     */
    public function installmentWechatNotify(): string
    {
        Log::debug('Installment Wechat Notify', app('alipay')->callback()->toArray());
        $data = app('wechat')->callback();
        if ($this->paid($data->out_trade_no, 'wechat', $data->transaction_id)) {
            return app('wechat')->success();
        }
        return 'fail';
    }

    /**
     * @param $outTradeNo
     * @param $paymentMethod
     * @param $paymentNo
     * @return bool
     */
    protected function paid($outTradeNo, $paymentMethod, $paymentNo): bool
    {
        // 因此可以通过支付订单号来还原出这笔还款是哪个分期付款的哪个还款计划
        [$no, $sequence] = explode('_', $outTradeNo);
        // 拉起支付时使用的支付订单号是由分期流水号 + 还款计划编号组成的
        // 根据分期流水号查询对应的分期记录，原则上不会找不到，这里的判断只是增强代码健壮性
        /** @var Installment $installment */
        if (!$installment = Installment::query()->where('no', $no)->first()) {
            return false;
        }
        // 根据还款计划编号查询对应的还款计划，原则上不会找不到，这里的判断只是增强代码健壮性
        if ($item = $installment->items()->where('sequence', $sequence)->first()) {
            return false;
        }
        // 如果这个还款计划的支付状态是已支付，则告知支付宝此订单已完成
        if ($item->paid_at) {
            return true;
        }

        // 更新对应的还款计划
        $item->update([
            'paid_at'        => Carbon::now(), // 支付时间
            'payment_method' => $paymentMethod, // 支付方式
            'payment_no'     => $paymentNo, // 支付宝订单号
        ]);

        // 如果这是第一笔还款
        if ($item->sequence === 0) {
            // 将分期付款的状态改为还款中
            $installment->update(['status' => Installment::STATUS_REPAYING]);
            // 将分期付款对应的商品订单状态改为已支付
            $installment->order->update([
                'paid_at'        => Carbon::now(),
                'payment_method' => 'installment', // 支付方式为分期付款
                'payment_no'     => $no, // 支付订单号为分期付款的流水号
            ]);
            // 触发商品订单已支付的事件
            event(new OrderPaid($installment->order));
        }

        // 如果这是最后一笔还款
        if ($item->sequence === $installment->count - 1) {
            $installment->update(['status' => Installment::STATUS_FINISHED]);
        }
        return true;
    }

}
