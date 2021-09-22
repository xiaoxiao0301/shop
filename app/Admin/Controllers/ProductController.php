<?php

namespace App\Admin\Controllers;

use App\Jobs\SyncOneProductToES;
use App\Models\Product;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Show;

class ProductController extends CommonProductsController
{

    public function getProductType()
    {
        return Product::TYPE_NORMAL;
    }

    protected $title = "普通商品管理";

    protected $description = [
        'create' => '创建普通商品',
        'index' => '普通商品列表',
    ];

    protected function customGrid(Grid $grid)
    {
        $grid->model()->with(['category']);
        $grid->column('id')->sortable();
        $grid->column('title', '商品名称');
        $grid->column('category.name', '类目');
        $grid->column('on_sale', '已上架')->display(function ($value) {
            return $value ? '是' : '否';
        });
        $grid->column('price', '价格');
        $grid->column('rating', '评分');
        $grid->column('sold_count', '销量');
        $grid->column('review_count', '评论数');
    }

    protected function customForm(Form $form)
    {
        $form->saved(function (Form $form, $result) {
            if ($form->isCreating()) {
                $productId = $result;
                $product = Product::find($productId);
            } else {
                /** @var Product $product */
                $product = $form->model();
            }
            dispatch(new SyncOneProductToES($product));
        });
    }
}
