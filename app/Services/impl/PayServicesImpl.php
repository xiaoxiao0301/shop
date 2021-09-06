<?php

namespace App\Services\impl;

use App\Dict\ResponseJsonData;
use App\Exceptions\InvalidRequestException;
use App\Models\Order;
use App\Services\PayServicesIf;
use Dcat\Admin\Grid\Displayers\QRCode;
use Illuminate\Http\JsonResponse;
use Log;

/**
 * 支付
 */
class PayServicesImpl implements PayServicesIf
{

    /**
     * 订单支付
     *
     * @param $user
     * @param $data
     * @return mixed
     * @throws InvalidRequestException
     */
    public function orderPay($user, $data)
    {
        $orderNo = $data['order_no'];
        $method = $data['method'];
        $totalAmount = $data['total_amount'];
        $orderInfo = Order::query()->where('order_no', $orderNo)->first();
        if ($orderInfo->user_id != $user->user_id) {
            return ResponseJsonData::responseUnProcessAble('无权限操作');
        }
        if ($orderInfo->paid_at || $orderInfo->closed) {
            throw new InvalidRequestException('订单状态不正确');
        }
        if ($method == 'alipay') {
            return $this->orderAliPay($orderNo, $totalAmount);
        } else {
            return $this->orderWechatPay($orderNo, $totalAmount);
        }
    }

    /**
     * 支付宝网页支付
     *
     * @param $orderNo
     * @param $amount
     * @return mixed
     */
    protected function orderAliPay($orderNo, $amount)
    {
        $result =  app('alipay')->scan([
            'out_trade_no' => $orderNo, // 订单编号，需保证在商户端不重复
            'total_amount' => $amount, // 订单金额，单位元，支持小数点后两位
            'subject' => '支付 Laravel Shop 的订单：'. $orderNo, // 订单标题
        ]);

        return QrCodeServicesImpl::generateOrCodePngFromUrl($result->qr_code);
    }

    /**
     * 微信扫码支付
     *
     * @param $orderNo
     * @param $amount
     * @return mixed
     */
    protected function orderWechatPay($orderNo, $amount)
    {
        $result =  app('wechat')->scan([
            'out_trade_no' => $orderNo,  // 商户订单流水号
            'description'      => '支付 Laravel Shop 的订单：'.$orderNo, // 订单描述
            'amount' => [
                'total' => $amount * 100, // 与支付宝不同，微信支付的金额单位是分。
            ],
        ]);
        return QrCodeServicesImpl::generateOrCodePngFromUrl($result->code_url);
    }


}
