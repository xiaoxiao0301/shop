<?php

namespace App\Listeners;

use App\Events\OrderPaid;
use App\Models\OrderItem;
use App\Models\Product;
use App\Notifications\SendOrderPaidNotification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

class UpdateProductSoldCount implements ShouldQueue
{
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     *
     * @param  OrderPaid  $event
     * @return void
     */
    public function handle(OrderPaid $event)
    {
        // 支付订单
        $order = $event->order;
        // 发送通知提示支付成功
        $order->user->notifyOrderPaid(new SendOrderPaidNotification($order));

        foreach ($order->items as $item) {
            /** @var OrderItem $item */
            $product = $item->product;
            // 计算商品的销量
            $soldCount = OrderItem::query()
                ->where('product_id', $product->id)
                ->whereHas('order', function ($query) {
                    $query->whereNotNull('paid_at'); // 关联已支付订单
                })->sum('amount');
            // 更新商品销量
            $order->update(['sold_count' => $soldCount]);
        }

    }
}
