<?php

namespace App\Admin\Controllers;

use App\Admin\Repositories\CrowdfundingProduct;
use App\Models\Product;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Show;

class CrowdfundingProductController extends CommonProductsController
{

    public function getProductType()
    {
        return Product::TYPE_CROWDFUNDING;
    }

    protected $title = "众筹商品管理";

    protected $description = [
        'create' => '创建众筹商品',
        'edit' => '编辑众筹商品',
        'index' => '众筹商品列表',
    ];

    protected function customGrid(Grid $grid)
    {
        $grid->model()->with(['crowdfunding']);
        $grid->column('id')->sortable();
        $grid->column('title', '商品名称');
        $grid->column('on_sale', '已上架')->display(function ($value) {
            return $value ? '是' : '否';
        });
        $grid->column('price', '价格');
        $grid->column('crowdfunding.target_amount', '目标金额');
        $grid->column('crowdfunding.end_time', '结束时间');
        $grid->column('crowdfunding.total_amount','目前金额');
//            $grid->column('user_count');
        $grid->column('crowdfunding.status', '状态')->display(function ($value) {
            return \App\Models\CrowdfundingProduct::$statusMap[$value];
        });
    }

    protected function customForm(Form $form)
    {
        // 添加众筹相关字段
        $form->text('crowdfunding.target_amount', '众筹目标金额')->rules('required|numeric|min:0.01');
        $form->datetime('crowdfunding.end_time', '众筹结束时间')->rules('required|date');
    }

    /**
     * Make a show builder.
     *
     * @param mixed $id
     *
     * @return Show
     */
    protected function detail($id)
    {
        return Show::make($id, new CrowdfundingProduct(), function (Show $show) {
            $show->field('id');
            $show->field('product_id');
            $show->field('target_amount');
            $show->field('total_amount');
            $show->field('user_count');
            $show->field('end_time');
            $show->field('status');
        });
    }

}
