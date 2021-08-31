<?php

namespace App\Jobs;

use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class CloseOrderJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $order;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct(Order $order, $delay)
    {
        $this->order = $order;
        // 延迟多少秒执行
        $this->delay($delay);
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        // 已经支持的订单不需要关闭
        if ($this->order->paid_at) {
            return;
        }
        DB::transaction(function () {
            // 关闭未支付订单
            $this->order->update(['closed' => true]);
            // 将订单的sku商品和数量写回去
            foreach ($this->order->items as $item) {
                $item->productSku->addStock($item->amount);
            }
            if ($this->order->couponCode) {
                // 关闭订单减少优惠券用量
                $this->order->couponCode->changeUsed(false);
            }
        });
    }
}
