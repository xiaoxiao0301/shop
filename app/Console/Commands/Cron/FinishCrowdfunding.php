<?php

namespace App\Console\Commands\Cron;

use App\Jobs\RefundCrowdfundingOrders;
use App\Models\CrowdfundingProduct;
use App\Models\Order;
use App\Services\impl\OrderServicesImpl;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Database\Query\Builder;

class FinishCrowdfunding extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'cron:finish-crowdfunding';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = '结束众筹';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        CrowdfundingProduct::query()
            ->with(['product'])
            ->where('end_time', '<=', Carbon::now())
            ->where('status', CrowdfundingProduct::STATUS_FUNDING)
            ->get()
            ->each(function (CrowdfundingProduct $crowdfundingProduct) {
                // 众筹目标金额大于实际众筹金额
                if ($crowdfundingProduct->target_amount > $crowdfundingProduct->total_amount) {
                    $this->crowdfundingFailed($crowdfundingProduct);
                } else {
                    $this->crowdfundingSucceed($crowdfundingProduct);
                }
            });
    }

    /**
     * 众筹失败
     *
     * @param CrowdfundingProduct $crowdfundingProduct
     */
    protected function crowdfundingFailed(CrowdfundingProduct $crowdfundingProduct)
    {
        // 修改状态，退款
        $crowdfundingProduct->update(['status' => CrowdfundingProduct::STATUS_FAIL]);
        // 异步队列去执行退款操作，比较耗时  php artisan queue:work
//        dispatch(new RefundCrowdfundingOrders($crowdfundingProduct));
        RefundCrowdfundingOrders::dispatch($crowdfundingProduct);
    }

    /**
     * 众筹成功
     *
     * @param CrowdfundingProduct $crowdfundingProduct
     */
    protected function crowdfundingSucceed(CrowdfundingProduct $crowdfundingProduct)
    {
        $crowdfundingProduct->update(['status' => CrowdfundingProduct::STATUS_SUCCESS]);
    }
}
