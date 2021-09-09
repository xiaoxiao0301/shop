<?php

namespace App\Listeners;

use App\Events\OrderReviewed;
use App\Models\OrderItem;
use DB;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Database\Query\Builder;
use Illuminate\Queue\InteractsWithQueue;

class UpdateProductRatingAndReviewCount
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
     * @param OrderReviewed $event
     * @return void
     */
    public function handle(OrderReviewed $event)
    {
        // 更新商品的评价数量和平均分
        $order = $event->order;
        foreach ($order->items as $item) {
            $result = OrderItem::query()
                ->where('product_id', $item->product_id)
                ->whereNotNull('review')
                ->whereHas('order', function ($query) {
                    /** @var Builder $query */
                    $query->whereNotNull('paid_at');
                })
                ->first([
                    DB::raw('count(*) as review_count'),
                    DB::raw('avg(rating) as rating')
                ]);

            $item->product->update([
                'rating' => $result['rating'],
                'review_count' => $result['review_count']
            ]);
        }
    }
}
