<?php

namespace App\Console\Commands\Elasticsearch;

use App\Models\Product;
use Exception;
use Illuminate\Console\Command;

class SyncProducts extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'es:sync-products {--index=products}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = '将商品数据同步到 Elasticsearch';

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
        $es = app('es');
        Product::query()
            ->with(['skus', 'properties'])
            ->chunkById(100, function ($products) use ($es) {
                $this->info(sprintf('正在同步 ID 范围为 %s 至 %s 的商品', $products->first()->id, $products->last()->id));
                $params = ['body' => []];
                foreach ($products as $product) {
                    // 将商品模型转为 Elasticsearch 所用的数组
                    $data = $product->toESArray();
                    // https://www.elastic.co/guide/en/elasticsearch/client/php-api/current/indexing_documents.html
                    $params['body'][] = [
                        'index' => [
                            '_index' => $this->option('index'),
                            '_id' => $data['id'],
                        ]
                    ];
                    $params['body'][]= $data;
                }

                try {
                    $es->bulk($params);
                } catch (Exception $exception) {
                    $this->error($exception->getMessage());
                }
            });

        $this->info('同步完成');

        return 0;
    }
}
