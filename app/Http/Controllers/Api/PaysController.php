<?php

namespace App\Http\Controllers\Api;

use App\Dict\ResponseJsonData;
use App\Exceptions\InvalidRequestException;
use App\Http\Requests\Api\PayRequest;
use App\Models\Order;
use Carbon\Carbon;
use Log;

class PaysController extends ApiBaseController
{

    /**
     * 支付订单
     *
     * @param PayRequest $request
     * @return mixed
     * @throws InvalidRequestException
     */
    public function pay(PayRequest $request)
    {
        $user = $this->userService->getUserInfoFromJwt();
        $data = $request->all();
        return $this->payService->orderPay($user, $data);
    }


    /**
     * 支付宝前端回调，web方式发起支付才会有
     */
    public function aliPayReturn()
    {
        Log::debug('AliPay Return', [app('aliapy')->callback()->toArray()]);
        try {
            app('aliapy')->callback();
        } catch (\Exception $exception) {
            Log::error('支付宝前端回调异常', ['msg' => $exception->getMessage()]);
            return ResponseJsonData::responseInternal();
        }
        return ResponseJsonData::responseOk();
    }

    /**
     * 支付宝服务器端回调
     *
     * @return string
     */
    public function aliPayNotify()
    {
        $data = app('alipay')->callback();
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
        return app('alipay')->success();
    }

    /**
     * 微信支付回调
     *
     * @return string
     */
    protected function wechatPayNotify()
    {
        $data = app('wechat')->callback();
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
            'payment_no'     => $data->trade_no, // 支付宝订单号
        ]);
        return app('wechat')->success();
    }
}
