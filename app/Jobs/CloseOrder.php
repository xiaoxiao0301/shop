<?php

namespace App\Jobs;

use App\Dict\RedisCacheKeys;
use App\Models\Coupon;
use App\Models\Order;
use App\Models\User;
use DB;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Redis;

class CloseOrder implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $order;

    protected $couponId;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct(Order $order, $couponId, $delay)
    {
        $this->order = $order;
        $this->couponId = $couponId;
        // 设置延迟的时间，delay() 方法的参数代表多少秒之后执行
        $this->delay($delay);
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        // 判断对应的订单是否已经被支付
        // 如果已经支付则不需要关闭订单，直接退出
        if ($this->order->paid_at) {
            return;
        }
        // 通过事务执行 sql
        DB::transaction(function() {
            // 将订单的 closed 字段标记为 true，即关闭订单
            $this->order->update(['closed' => true]);
            // 循环遍历订单中的商品 SKU，将订单中的数量加回到 SKU 的库存中去
            foreach ($this->order->items as $item) {
                $item->productSku->addStock($item->amount);
                // 当前订单类型是秒杀订单，并且对应商品是上架且尚未到截止时间
                if ($item->order->type === Order::TYPE_SECKILL
                    && $item->product->on_sale
                    && !$item->product->seckill->is_after_end) {
                    // 将 Redis 中的库存 +1
                    Redis::incr(RedisCacheKeys::SECKILL_PRODUCT_STOCK_KEY . $item->productSku->id);
                }
                if (!is_null($this->couponId)) {
                    $user = User::query()->where('user_id', $this->order->user_id)->first();
                    /** @var User $user */
                    $user->coupons()->where('coupon_id', $this->couponId)
                        ->update([
                            'used'=> false,
                            'order_id' => null
                        ]);
                    Coupon::query()->where('id', $this->couponId)->decrement('used_number', 1);
                }

            }
        });
    }
}
