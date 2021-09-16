<?php

namespace App\Admin\Controllers;

use App\Admin\Repositories\Product;
use App\Models\Category;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Show;

class ProductController extends CommonProductsController
{

    public function getProductType()
    {
        return \App\Models\Product::TYPE_NORMAL;
    }

    protected $title = "普通商品管理";

    protected $description = [
        'create' => '创建普通商品',
        'index' => '普通商品列表',
    ];

    /**
     * Make a show builder.
     *
     * @param mixed $id
     *
     * @return Show
     */
    protected function detail($id)
    {
        return Show::make($id, new Product(), function (Show $show) {
            $show->field('id');
            $show->field('title');
            $show->field('description');
            $show->field('image')->image();
            $show->field('on_sale');
            $show->field('rating');
            $show->field('sold_count');
            $show->field('review_count');
            $show->field('price');
            $show->field('created_at');
            $show->field('updated_at');

            // 禁用编辑页面删除按钮
            $show->disableDeleteButton();
        });
    }

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
        // 普通商品没有额外的字段
    }
}
