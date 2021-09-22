<?php

namespace App\Admin\Controllers;

use App\Dict\RedisCacheKeys;
use App\Jobs\SyncOneProductToES;
use App\Models\Product;
use App\Models\ProductSku;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Illuminate\Support\Facades\Redis;

class SeckillProductController extends CommonProductsController
{

    public function getProductType()
    {
        return Product::TYPE_SECKILL;
    }

    protected $title = "秒杀商品管理";

    protected $description = [
        'create' => '秒杀众筹商品',
        'edit' => '秒杀众筹商品',
        'index' => '秒杀商品列表',
    ];

    protected function customGrid(Grid $grid)
    {
        $grid->model()->with(['seckill']);
        $grid->column('id')->sortable();
        $grid->column('title', '商品名称');
        $grid->column('on_sale', '已上架')->display(function ($value) {
            return $value ? '是' : '否';
        });
        $grid->column('price', '价格');
        $grid->column('seckill.start_time', '秒杀开始时间');
        $grid->column('seckill.end_time', '秒杀结束时间');
        $grid->column('sold_count','销量');
    }

    protected function customForm(Form $form)
    {
        // 添加秒杀相关字段
        $form->datetime('seckill.start_time', '秒杀开始时间')->rules('required|date');
        $form->datetime('seckill.end_time', '众筹结束时间')->rules('required|date');

        $form->saved(function (Form $form, $result) {
            if ($form->isCreating()) {
                $productId = $result;
                $product = Product::find($productId);
            } else {
                /** @var Product $product */
                $product = $form->model();
            }
            // 商品重新加载秒杀字段
            dispatch(new SyncOneProductToES($product));
            // fresh 方法会重新从数据库中检索模型。现有的模型实例不受影响：refresh 方法使用数据库中的新数据重新赋值现有模型
            $product = $product->refresh();
            $product->load(['seckill']);
            // 获取当前时间与秒杀结束时间的差值
            $diff = $product->seckill->end_time->getTimestamp() - time();
            // 遍历商品 SKU
            $product->skus->each(function (ProductSku $sku) use ($diff, $product) {
                // 如果秒杀商品是上架并且尚未到结束时间
                if ($product->on_sale && $diff > 0) {
                    // 将剩余库存写入到 Redis 中，并设置该值过期时间为秒杀截止时间
                    Redis::setex(RedisCacheKeys::SECKILL_PRODUCT_STOCK_KEY . $sku->id, $diff, $sku->stock);
                } else {
                    // 否则将该 SKU 的库存值从 Redis 中删除
                    Redis::del(RedisCacheKeys::SECKILL_PRODUCT_STOCK_KEY . $sku->id);
                }
            });
        });
    }

}
