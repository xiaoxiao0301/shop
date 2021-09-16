<?php

namespace App\Jobs;

use App\Models\CrowdfundingProduct;
use App\Models\Order;
use App\Services\impl\OrderServicesImpl;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Database\Query\Builder;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

// ShouldQueue 代表此任务需要异步执行
class RefundCrowdfundingOrders implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $crowdfunding;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct(CrowdfundingProduct $crowdfundingProduct)
    {
        $this->crowdfunding = $crowdfundingProduct;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        if ($this->crowdfunding->status === CrowdfundingProduct::STATUS_FAIL) {
            /** @var OrderServicesImpl $orderService */
            $orderService = app(OrderServicesImpl::class);
            Order::query()
                ->where('type', Order::TYPE_CROWDFUNDING)
                ->whereNotNull('paid_at')
                ->whereHas('items', function ($query) {
                    /** @var Builder $query */
                    $query->where('product_id', $this->crowdfunding->product_id);
                })
                ->get()
                ->each(function (Order $order) use ($orderService) {
                    $orderService->refundOrder($order);
                });
        }

    }
}
