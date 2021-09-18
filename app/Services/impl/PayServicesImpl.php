<?php

namespace App\Services\impl;

use App\Dict\ResponseJsonData;
use App\Exceptions\InvalidRequestException;
use App\Models\Installment;
use App\Models\Order;
use App\Services\PayServicesIf;
use Brick\Math\BigDecimal;
use Brick\Math\RoundingMode;
use Carbon\Carbon;
use Exception;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\Routing\ResponseFactory;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

/**
 * 支付
 */
class PayServicesImpl implements PayServicesIf
{

    /**
     * 普通订单支付
     *
     * @param $user
     * @param $data
     * @return Application|ResponseFactory|JsonResponse|Response
     * @throws InvalidRequestException
     * @throws Exception
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
     * 创建分期订单
     *
     * @param Order $order
     * @param $user
     * @param $count
     * @return JsonResponse
     * @throws InvalidRequestException
     */
    public function createPayInstallment(Order $order, $user, $count): JsonResponse
    {
        // 订单已支付或者已关闭
        if ($order->paid_at || $order->closed) {
            throw new InvalidRequestException('订单状态不正确');
        }
        // 删除同一笔商品订单发起过其他的状态是未支付的分期付款，避免同一笔商品订单有多个分期付款
        Installment::query()
            ->where('order_id', $order->order_no)
            ->where('status', Installment::STATUS_PENDING)
            ->delete();

        $installment = new Installment([
            // 总本金即为商品订单总金额
            'total_amount' => $order->total_amount,
            // 分期期数
            'count' => $count,
            // 期数的费率
            'fee_rate' => config('installment.installment_fee_rate')[$count],
            // 当期逾期费率
            'fine_rate' => config('installment.installment_fine_rate'),
        ]);
        $installment->user()->associate($user);
        $installment->order()->associate($order);
        $installment->save();
        // 第一期的还款截止日期为明天凌晨 0 点
        $dueDate = Carbon::tomorrow();
        // 计算每一期的本金
        $base = BigDecimal::of($order->total_amount)->dividedBy($count, 2, RoundingMode::DOWN);
        // 计算每一期的手续费
        $fee = BigDecimal::of($base)->multipliedBy($installment->fee_rate)->dividedBy(100, 2, RoundingMode::DOWN);
        for ($i = 0; $i < $count; $i++) {
            if ($i == $count - 1) {
                // 最后一期的本金需要总本金减去前面几期的本金
                $base = BigDecimal::of($order->total_amount)->minus(BigDecimal::of($base)->multipliedBy($count - 1));
            }
            $installmentItem = $installment->items()->make([
                'sequence' => $i,
                'base' => $base,
                'fee' => $fee,
                'due_date' => $dueDate,
            ]);
            $installmentItem->save();
            // 还款截止日期加30天
            $dueDate = $dueDate->copy()->addDays(30);
        }
        return ResponseJsonData::responseOk();
    }

    /**
     * 支付分期订单-支付宝
     *
     * @param Installment $installment
     * @return Application|ResponseFactory|Response
     * @throws InvalidRequestException
     * @throws Exception
     */
    public function installmentOrderPayByAli(Installment $installment)
    {
        if ($installment->order->closed) {
            throw new InvalidRequestException('订单已关闭');
        }
        if ($installment->status === Installment::STATUS_FINISHED) {
            throw new InvalidRequestException('该分期订单已结清');
        }
        // 获取当前分期付款最近的一个未支付的还款计划
        if (!$nextItem = $installment->items()->whereNull('paid_at')->orderBy('sequence')->first()) {
            // 如果没有未支付的还款，原则上不可能，因为如果分期已结清则在上一个判断就退出了
            throw new InvalidRequestException('该分期订单已结清');
        }

        $result = app('alipay')->scan([
            // 支付订单号使用分期流水号+还款计划编号
            'out_trade_no' => $installment->no . '_' . $nextItem->sequence,
            'total_amount' => $nextItem->total,
            'subject' => '支付 Laravel Shop 的分期订单：'. $installment->no,
            'notify_url' => frp_url('installment.alipay.notify'),
        ]);

        return QrCodeServicesImpl::generateOrCodePngFromUrl($result->qr_code);

    }

    /**
     * 支付分期订单-微信
     *
     * @param Installment $installment
     * @return Application|ResponseFactory|Response
     * @throws InvalidRequestException
     * @throws Exception
     */
    public function installmentWechatPay(Installment $installment)
    {
        if ($installment->order->closed) {
            throw new InvalidRequestException('订单已关闭');
        }
        if ($installment->status === Installment::STATUS_FINISHED) {
            throw new InvalidRequestException('该分期订单已结清');
        }
        // 获取当前分期付款最近的一个未支付的还款计划
        if (!$nextItem = $installment->items()->whereNull('paid_at')->orderBy('sequence')->first()) {
            // 如果没有未支付的还款，原则上不可能，因为如果分期已结清则在上一个判断就退出了
            throw new InvalidRequestException('该分期订单已结清');
        }
        $result =  app('wechat')->scan([
            'out_trade_no' => $installment->no . '_' . $nextItem->sequence,
            'description'      => '支付 Laravel Shop 的订单：'.$installment->no, // 订单描述
            'amount' => [
                'total' => $nextItem->total * 100, // 与支付宝不同，微信支付的金额单位是分。
            ],
            'attach' => 'pay',
            'notify_url' => frp_url('installment.wechat.notify'),
        ]);
        return QrCodeServicesImpl::generateOrCodePngFromUrl($result->code_url);
    }


    /**
     * 支付宝扫码支付
     *
     * @param $orderNo
     * @param $amount
     * @return Application|ResponseFactory|Response
     * @throws Exception
     */
    protected function orderAliPay($orderNo, $amount)
    {
        $result =  app('alipay')->scan([
            'out_trade_no' => $orderNo, // 订单编号，需保证在商户端不重复
            'total_amount' => $amount, // 订单金额，单位元，支持小数点后两位
            'subject' => '支付 Laravel Shop 的订单：'. $orderNo, // 订单标题
            'notify_url' => frp_url('api.alipay.notify'),
        ]);

        return QrCodeServicesImpl::generateOrCodePngFromUrl($result->qr_code);
    }

    /**
     * 微信扫码支付
     *
     * @param $orderNo
     * @param $amount
     * @return Application|ResponseFactory|Response
     * @throws Exception
     */
    protected function orderWechatPay($orderNo, $amount)
    {
        $result =  app('wechat')->scan([
            'out_trade_no' => $orderNo,  // 商户订单流水号
            'description'      => '支付 Laravel Shop 的订单：'.$orderNo, // 订单描述
            'amount' => [
                'total' => $amount * 100, // 与支付宝不同，微信支付的金额单位是分。
            ],
            'attach' => 'pay',
        ]);
        return QrCodeServicesImpl::generateOrCodePngFromUrl($result->code_url);
    }


}
