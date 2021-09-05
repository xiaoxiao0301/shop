<?php

namespace App\Admin\Controllers;

use App\Admin\Repositories\Coupon;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Show;
use Dcat\Admin\Http\Controllers\AdminController;

class CouponController extends AdminController
{
    protected $title = '优惠券管理';

    protected $description = [
        'index' => '优惠券列表',
        'create' => '新增优惠券',
        'edit' => '编辑优惠券',
        'show' => '优惠券详情',
    ];

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        return Grid::make(new Coupon(), function (Grid $grid) {
            $grid->setActionClass(Grid\Displayers\Actions::class);
            // 创建时间倒序排列
            $grid->model()->orderBy('created_at', 'desc');

            $grid->column('id')->sortable();
            $grid->column('title', '名称');
            $grid->column('code', '优惠码');
            $grid->column('read', '描述');
//            $grid->column('description', '描述');
            $grid->column('type')->display(function ($value) {
                return \App\Models\Coupon::$typeMap[$value];
            });
            $grid->column('value')->display(function ($value) {
                return $this->type == \App\Models\Coupon::TYPE_FIXED ? '￥' . $value : $value. '%';
            });
            $grid->column('total_number');
            $grid->column('got_number');
            $grid->column('used_number');
//            $grid->column('start_time');
//            $grid->column('end_time');
            $grid->column('min_amount');
            $grid->column('is_available')->display(function ($value) {
                return $value ? '是' : '否';
            });
//            $grid->column('shop_id');
//            $grid->column('created_at');
//            $grid->column('updated_at')->sortable();

            $grid->filter(function (Grid\Filter $filter) {
                $filter->equal('id');

            });

            $grid->disableFilterButton();
            $grid->disableRowSelector();
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
        return Show::make($id, new Coupon(), function (Show $show) {
            $show->field('id');
            $show->field('title');
            $show->field('description');
            $show->field('code');
            $show->field('type', '类型')->as(function ($value) {
                return \App\Models\Coupon::$typeMap[$value];
            });
            $show->field('value');
            $show->field('total_number');
            $show->field('got_number');
            $show->field('used_number');
            $show->field('min_amount', '最低金额');
            $show->field('start_time', '开始时间');
            $show->field('end_time', '结束时间');
            $show->field('is_available')->as(function ($value) {
                return $value ? '是' : '否';
            });
            $show->field('created_at');
//            $show->field('updated_at');


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
        return Form::make(new Coupon(), function (Form $form) {
            $form->display('id');
            $form->text('title')->rules('required');
            $form->text('description')->rules('required');
            $form->text('code')->rules(function ($form) {
                if ($id = $form->model()->id) {
                    return 'nullable|unique:coupons,code,'.$id.',id';
                } else {
                    return 'required|unique:coupons';
                }
            });
            $form->select('type', '类型')->options(\App\Models\Coupon::$typeMap)->default(\App\Models\Coupon::TYPE_FIXED)->rules('required');
            $form->text('value', '折扣')->rules(function ($form) {
                if ($form->type == \App\Models\Coupon::TYPE_FIXED) {
                    return 'required|numeric|min:10';
                } else {
                    // 如果选择了百分比折扣类型，那么折扣范围只能是 1 ~ 99
                    return 'required|numeric|between:1,99';
                }
            });
            $form->text('total_number')->rules('required|numeric|min:0');
//            $form->text('used');
            $form->text('min_amount', '最低金额')->rules('required|numeric|min:0');
            $form->datetime('start_time', '开始时间');
            $form->datetime('end_time', '结束时间');
            $form->switch('is_available', '启用')->default(false);

//            $form->display('created_at');
//            $form->display('updated_at');

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
