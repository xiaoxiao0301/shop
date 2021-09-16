<?php

namespace App\Listeners;

use App\Events\OrderPaid;
use App\Models\Order;
use DB;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Database\Query\Builder;
use Illuminate\Queue\InteractsWithQueue;

class UpdateCrowdfundingProductProgress
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
        $order = $event->order;
        if ($order->type !== Order::TYPE_NORMAL) {
            $crowdfunding = $order->items[0]->product->crowdfunding;
            $data = Order::query()
                ->where('type', Order::TYPE_CROWDFUNDING)
                ->whereNotNull('paid_at')
                ->whereHas('items', function ($query) use ($crowdfunding) {
                    /** @var Builder $query */
                    $query->where('product_id', $crowdfunding->product_id);
                })
                ->first([
                    // 总订单金额
                    DB::raw('sum(total_amount) as total_amount'),
                    // 用户个数
                    DB::raw('count(distinct(user_id)) as user_count'),
                ]);
            $crowdfunding->update([
                'total_amount' => $data->total_amount,
                'user_count' => $data->user_count,
            ]);
        }
    }
}
