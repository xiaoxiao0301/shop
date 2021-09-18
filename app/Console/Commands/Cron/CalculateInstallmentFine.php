<?php

namespace App\Console\Commands\Cron;

use App\Models\Installment;
use App\Models\InstallmentItem;
use Brick\Math\BigDecimal;
use Brick\Math\RoundingMode;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Database\Query\Builder;

class CalculateInstallmentFine extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'cron:calculate-installment-fine';

    /**
     * The console command description.
     * 逾期费的计算公式为：
     *    逾期天数 * 逾期金额 * 逾期费率，假设逾期费率为 0.05%，
     *    逾期金额（即当期本金 + 手续费）为 1000，逾期 10 天，那么逾期费为 10 * 1000 * 0.05% = 5 元。
     *    由于国家规定逾期费不得超过当期本金 + 手续费，如果上述公式计算出来的逾期费超过了 1000 元则逾期费为 1000 元。
     * @var string
     */
    protected $description = '计算分期账单的逾期费';

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
        InstallmentItem::query()
            ->with(['installment'])
            ->whereHas('installment', function ($query) {
                /** @var Builder $query */
                $query->where('status', Installment::STATUS_REPAYING); // 状态是还款中
            })
            // 还款截止日期在当前时间之前
            ->where('due_date', '<=', Carbon::now())
            ->whereNull('paid_at')
            // 使用 chunkById 避免一次性查询太多记录
            ->chunkById(1000, function ($items) {
                foreach ($items as $item) {
                    // 通过 Carbon 对象的 diffInDays 直接得到逾期天数
                    $overdueDays = Carbon::now()->diffInDays($item->due_date);
                    // 本金与手续费之和
                    $base = BigDecimal::of($item->base)->plus($item->fee);
                    // 计算逾期费
                    $fine = BigDecimal::of($base)
                        ->multipliedBy($overdueDays)
                        ->multipliedBy($item->installment->fine_rate)
                        ->dividedBy(1000, 2, RoundingMode::DOWN);
                    $fine = BigDecimal::of($fine)->compareTo($base) === 1 ? $base : $fine;
                    $item->update([
                        'fine' => $fine
                    ]);
                }
            });
        $this->info('计算逾期费成功');
        return 0;
    }
}
