<?php

namespace App\Console\Commands\Cron;

use App\Services\impl\OrderServicesImpl;
use Illuminate\Console\Command;

class ClosedNotPayOrder extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'cron:close-order';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'close not pay order';


    protected $orderServiceImpl;
    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
        $this->orderServiceImpl = new OrderServicesImpl();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        // 关闭未支付订单，放到队列里面执行
        $this->orderServiceImpl->closeNotPayOrder();
        $this->info('success');
    }
}
