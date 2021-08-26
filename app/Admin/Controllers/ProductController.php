<?php

namespace App\Admin\Controllers;

use App\Admin\Repositories\Product;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Show;
use Dcat\Admin\Http\Controllers\AdminController;

class ProductController extends AdminController
{
    protected $title = "商品管理";

    protected $description = [
        'create' => '创建商品',
        'index' => '商品列表',
    ];

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        return Grid::make(new Product(), function (Grid $grid) {

            // 设置操作为图标展开式
            $grid->setActionClass(Grid\Displayers\Actions::class);

            $grid->column('id')->sortable();
            $grid->column('title');
//            $grid->column('description');
            $grid->column('image')->image('', 50, 50);
            $grid->column('on_sale', '已上架')->display(function ($value) {
                return $value ? '是' : '否';
            });
            $grid->column('rating');
            $grid->column('sold_count');
            $grid->column('review_count');
            $grid->column('price');
//            $grid->column('created_at');
//            $grid->column('updated_at')->sortable();

            $grid->filter(function (Grid\Filter $filter) {
                $filter->equal('id');

            });

            // 开启弹窗创建表单
            $grid->enableDialogCreate();
            // 设置弹窗的宽，高
            $grid->setDialogFormDimensions('65%', '75%');

            // 禁用过滤器按钮
            $grid->disableFilterButton();

            // 禁用 行选择器
            $grid->disableRowSelector();

            // 禁用删除按钮
            $grid->disableDeleteButton();

            // 禁用详情按钮
            $grid->disableViewButton();


        });
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
        return Show::make($id, new Product(), function (Show $show) {
//            $show->field('id');
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

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        return Form::make(Product::with('skus'), function (Form $form) {
            $form->display('id');
            $form->text('title')->rules('required');
            $form->image('image')->autoUpload()->rules('required')->removable(false)->uniqueName();
            $form->editor('description')->rules('required');
            $form->switch('on_sale', '上架')->default(true);

            // 第一个参数必须和主模型中定义此关联关系的方法同名
            $form->hasMany('skus', 'SKU列表', function (Form\NestedForm $form) {
                $form->text('title', 'SKU名称')->rules('required');
                $form->text('description', 'SKU描述')->rules('required');
                $form->text('price', '单价')->rules('required|numeric|min:0.01');
                $form->text('stock', '库存')->rules('required|integer|min:0');
            });

            // 修改模型中的数据需要配合隐藏表单使用
            $form->hidden('price');
            $form->saving(function (Form $form) {
                $form->price = collect($form->input('skus'))->where(Form::REMOVE_FLAG_NAME, 0)->min('price') ?: 0;
            });

            // 禁用编辑页面删除按钮
            $form->disableDeleteButton();


            // 去掉底部按钮
            $form->footer(function ($footer) {
                // 去掉`查看`checkbox
                $footer->disableViewCheck();

                // 去掉`继续编辑`checkbox
                $footer->disableEditingCheck();

                // 去掉`继续创建`checkbox
                $footer->disableCreatingCheck();
            });


        });
    }
}
