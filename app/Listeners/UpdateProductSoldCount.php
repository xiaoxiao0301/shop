<?php

namespace App\Listeners;

use App\Models\OrderItem;
use App\Notifications\OrderPaid;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Database\Query\Builder;
use Illuminate\Queue\InteractsWithQueue;

class UpdateProductSoldCount
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
     * @param  object  $event
     * @return void
     */
    public function handle($event)
    {
        $order = $event->order;

        // 发送站内信提示支付成功
        $order->user->notifyOrderPaid(new OrderPaid($order));

        foreach ($order->items as $item) {
            // 获取当前订单下所有商品的数量然后再更新到商品表销量
            $product = $item->product;
            // 获取商品的数量
            $count = OrderItem::query()
                ->where('product_id', $product->id)
                ->where('order_id', $order->order_no)
                ->whereHas('order', function ($query) {
                    /** @var Builder $query */
                    $query->whereNotNull('paid_at'); // 订单必须是已支付
                })->sum('amount');
//             更新商品的数量

            $product->sold_count = $count + $product->sold_count;
            $product->save();
        }
    }
}
