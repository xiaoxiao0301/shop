<?php

namespace App\Admin\Controllers;

use App\Admin\Repositories\CouponCode;
use App\dict\CouponDict;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Show;
use Dcat\Admin\Http\Controllers\AdminController;

class CouponCodeController extends AdminController
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
        return Grid::make(new CouponCode(), function (Grid $grid) {
            // 创建时间倒序排列
            $grid->model()->orderBy('created_at', 'desc');

            $grid->setActionClass(Grid\Displayers\Actions::class);

            $grid->column('id')->sortable();
            $grid->column('name', '名称');
            $grid->column('code', '优惠码');
//            $grid->column('type', '类型')->display(function ($value) {
//                return CouponDict::$typeMap[$value];
//            });
//            $grid->column('value', '折扣')->display(function ($value) {
//                return $this->type == CouponDict::TYPE_FIXED ? '￥' . $value : $value. '%';
//            });
//            $grid->column('min_amount', '最低金额');
//            $grid->column('total', '总量');
//            $grid->column('used', '已用');
//            $grid->column('not_before');
//            $grid->column('not_after');
            $grid->column('description', '描述');
            $grid->column('used', '用量')->display(function ($value) {
                return "{$this->used} / {$this->total}";
            });
            $grid->column('enabled', '是否启用')->display(function ($value) {
                return $value ? '是' : '否';
            });
            $grid->column('created_at');
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
        return Show::make($id, new CouponCode(), function (Show $show) {
            $show->field('id');
            $show->field('name');
            $show->field('code');
            $show->field('type', '类型')->as(function ($value) {
                return CouponDict::$typeMap[$value];
            });
            $show->field('value');
            $show->field('total');
            $show->field('used');
            $show->field('min_amount', '最低金额');
            $show->field('not_before', '开始时间');
            $show->field('not_after', '结束时间');
            $show->field('enabled')->as(function ($value) {
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
        return Form::make(new CouponCode(), function (Form $form) {
            $form->display('id');
            $form->text('name')->rules('required');
            $form->text('code')->rules(function ($form) {
               if ($id = $form->model()->id) {
                   return 'nullable|unique:coupon_codes,code,'.$id.',id';
               } else {
                   return 'required|unique:coupon_codes';
               }
            });
            $form->select('type', '类型')->options(CouponDict::$typeMap)->default(CouponDict::TYPE_FIXED)->rules('required');
            $form->text('value', '折扣')->rules(function ($form) {
                if ($form->type == CouponDict::TYPE_FIXED) {
                    return 'required|numeric|min:0.01';
                } else {
                    // 如果选择了百分比折扣类型，那么折扣范围只能是 1 ~ 99
                    return 'required|numeric|between:1,99';
                }
            });
            $form->text('total')->rules('required|numeric|min:0');
//            $form->text('used');
            $form->text('min_amount', '最低金额')->rules('required|numeric|min:0');
            $form->datetime('not_before', '开始时间');
            $form->datetime('not_after', '结束时间');
            $form->switch('enabled', '启用')->default(false);

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
