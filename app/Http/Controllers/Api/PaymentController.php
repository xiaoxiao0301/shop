<?php

namespace App\Http\Controllers\Api;



use App\dict\Codes;
use App\Events\OrderPaid;
use App\Exceptions\InternalException;
use App\Exceptions\InvalidRequestException;
use App\Models\Order;
use Carbon\Carbon;
use Exception;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\Routing\ResponseFactory;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Log;

class PaymentController extends BaseController
{
    /**
     * 支付订单
     *
     * @param Order $order
     * @param Request $request
     * @return Application|ResponseFactory|JsonResponse|Response|mixed
     * @throws InvalidRequestException
     */
    public function payOrder(Order $order, Request $request)
    {
        try {
            $this->authorize('own', $order);
            $payMethod = $request->input('method');
            if (!$payMethod) {
                return $this->orderService->orderPaymentByAli($order);
            } else {
                return $this->orderService->orderPaymentByWechat($order);
            }
        } catch (AuthorizationException $exception) {
            return $this->responseData(Codes::CODE_ACTION_NOT_ALLOWED, [], Codes::STATUS_CODE_FORBIDDEN);
        }
    }


    // 支付宝前端回调
    public function alipayReturn()
    {
        try {
            app('alipay')->verify();
        } catch (Exception $exception) {
            Log::error("支付订单前端返回出错:", [
                'msg' => $exception->getMessage()
            ]);
            return response()->json([
                "code" => Codes::CODE_NETWORK_BUSY,
                "message" => '数据不正确',
                "data" => []
            ])->setStatusCode(Codes::STATUS_CODE_ERROR_INTERNAL);
        }
        return $this->responseData(Codes::CODE_SUCCESS, [], Codes::STATUS_CODE_OK);
    }

    // 支付宝服务器端回调
    public function alipayNotify()
    {
        // 校验提交的参数是否合法
        $data = app('alipay')->verify();
        // $data->out_trade_no 拿到订单流水号，并在数据库中查询
        $order = Order::where('order_no', $data->out_trade_no)->first();
        // 正常来说不太可能出现支付了一笔不存在的订单，这个判断只是加强系统健壮性。
        if (!$order) {
            return 'fail';
        }
        // 如果这笔订单的状态已经是已支付
        if ($order->paid_at) {
            // 返回数据给支付宝
            return app('alipay')->success();
        }
        $order->update([
            'paid_at'        => Carbon::now(), // 支付时间
            'payment_method' => 'alipay', // 支付方式
            'payment_no'     => $data->trade_no, // 支付宝订单号
        ]);

        // 事件
        $this->payNotificationAndIncrementProductSold($order);

        return app('alipay')->success();
    }

    // 微信支付服务器端回调
    public function wechatNotify()
    {
        // 校验回调参数是否正确
        $data  = app('wechat_pay')->verify();
        // 找到对应的订单
        $order = Order::where('no', $data->out_trade_no)->first();
        // 订单不存在则告知微信支付
        if (!$order) {
            return 'fail';
        }
        // 订单已支付
        if ($order->paid_at) {
            // 告知微信支付此订单已处理
            return app('wechat_pay')->success();
        }

        // 将订单标记为已支付
        $order->update([
            'paid_at'        => Carbon::now(),
            'payment_method' => 'wechat',
            'payment_no'     => $data->transaction_id,
        ]);

        // 事件通知
        $this->payNotificationAndIncrementProductSold($order);

        return app('wechat_pay')->success();
    }

    /**
     * 支付完成后更新商品的销量
     *
     * @param Order $order
     */
    protected function payNotificationAndIncrementProductSold(Order $order)
    {
        event(new OrderPaid($order));
    }

}
