<?php

namespace App\Jobs;

use App\Exceptions\InternalBusyException;
use App\Models\Installment;
use App\Models\InstallmentItem;
use App\Models\Order;
use Exception;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Log;

/**
 * ShouldQueue 代表这是一个异步任务
 * 分期订单的退款，由于需要退还多笔，借鉴微信退款
 */
class RefundInstallmentOrder implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $order;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct(Order $order)
    {
        $this->order = $order;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        // 如果商品订单支付方式不是分期付款、订单未支付、订单退款状态不是退款中，直接退出
        if ($this->order->payment_method !== 'installment'
            || !$this->order->paid_at
            || $this->order->refund_status !== Order::REFUND_STATUS_PROCESSING) {
            return;
        }
        if (!$installment = Installment::query()->where('order_id', $this->order->order_no)->first()) {
            return;
        }
        // 遍历对应分期付款的所有还款计划
        /** @var Installment $installment */
        foreach ($installment->items as $item) {
            // 如果还款计划未支付，或者退款状态为退款成功或退款中，则跳过
            /** @var InstallmentItem $item */
            if (!$item->paid_at || in_array($item->refund_status, [
                    InstallmentItem::REFUND_STATUS_SUCCESS,
                    InstallmentItem::REFUND_STATUS_PROCESSING,
                ])) {
                continue;
            }

            // 退款逻辑
            try {
                $this->refundInstallmentItem($item);
            } catch (Exception $exception) {
                Log::warning('分期退款失败' . $exception->getMessage(), [
                    'installment_item_id' => $item->id,
                ]);
                // 表示当前的还款报错了，暂时跳过，处理下一个计划的退款
                continue;
            }

            $installment->refreshRefundStatus();
        }
    }

    /**
     * 处理退款， 分期只退款本金
     *
     * @param InstallmentItem $item
     * @throws InternalBusyException
     */
    protected function refundInstallmentItem(InstallmentItem $item)
    {
        // 退款单号使用商品订单的退款号与当前还款计划的序号拼接而成
        $refundNo = $this->order->refund_no.'_'.$item->sequence;
        // 根据还款计划的支付方式执行对应的退款逻辑
        switch ($item->payment_method) {
            case 'wechat':
                $refundData = [
                    'transaction_id' => $item->payment_no, // 这里我们使用微信订单号来退款
                    'out_refund_no' => $refundNo,
                    'amount' => [
                        'refund' => $item->base * 100,
                        'total' => $item->total * 100,
                        'currency' => 'CNY',
                    ],
                ];
                // 微信退款是异步的哈, v3版本待测试
                app('wechat')->refund($refundData);
                // 将还款计划退款状态改成退款中
                $item->update([
                    'refund_status' => InstallmentItem::REFUND_STATUS_PROCESSING,
                ]);
                break;
            case 'alipay':
                $result = app('alipay')->refund([
                    'trade_no' => $item->payment_no, // 使用支付宝交易号来退款
                    'refund_amount' => $item->base, // 退款金额，单位元，只退回本金
                    'out_request_no' => $refundNo,  // 退款订单号
                ]);
                Log::debug('refundInstallmentItem-支付宝退款回调参数:', $result->toArray());
                // 根据支付宝的文档，如果返回值里有 sub_code 字段说明退款失败
                if ($result->sub_code) {
                    // 退款失败
                    $item->update(['refund_status' => InstallmentItem::REFUND_STATUS_FAILED]);
                } else {
                    // 退款成功, 将订单的退款状态标记为退款成功并保存退款订单号
                    $item->update(['refund_status' => InstallmentItem::REFUND_STATUS_SUCCESS]);
                }
                break;
            default:
                throw new InternalBusyException('未知订单支付方式' . $item->payment_method);
        }
    }
}
