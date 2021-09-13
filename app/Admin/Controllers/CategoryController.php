<?php

namespace App\Admin\Controllers;

use App\Admin\Repositories\Category;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Show;
use Dcat\Admin\Http\Controllers\AdminController;
use Illuminate\Http\Request;

class CategoryController extends AdminController
{
    protected $title = "商品类目管理";

    protected $description = [
        'create' => '创建商品类目',
        'index' => '商品类目列表',
        'edit' => '编辑商品类目',
    ];
    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        return Grid::make(new Category(), function (Grid $grid) {
            $grid->setActionClass(Grid\Displayers\Actions::class);

            $grid->column('id')->sortable();
            $grid->column('name');
//            $grid->column('parent_id');
            $grid->column('level');
            $grid->column('is_directory')->display(function ($value) {
                return $value ? '是' : '否';
            });
            $grid->column('path');
//            $grid->column('created_at');
//            $grid->column('updated_at')->sortable();

            $grid->filter(function (Grid\Filter $filter) {
                $filter->equal('id');

            });

            $grid->disableRowSelector();
            $grid->disableFilterButton();
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
        return Show::make($id, new Category(), function (Show $show) {
            $show->field('id');
            $show->field('name');
            $show->field('parent_id');
            $show->field('is_directory');
            $show->field('level');
            $show->field('path');
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
        // 传入 parent 关联 parent数据
        return Form::make(new Category('parent'), function (Form $form) {
            $form->display('id');
            $form->text('name')->rules('required');
//            $form->text('parent_id');
//            $form->text('level');
//            $form->text('path');
//            $form->display('created_at');
//            $form->display('updated_at');

            if ($form->isEditing()) {
                // 是否是编辑
                $form->display('is_directory')->with(function ($value) {
                    return $value ? '是' : '否';
                });
                $form->display('parent.name', '父类目');
            } else {
                $form->radio('is_directory')->options(['1' => '是', '0' => '否'])->default('0')->rules('required');
                // 父类目的下拉框
                $form->select('parent_id')->ajax('api/categories');
            }




            // 禁用编辑页面删除按钮
            $form->disableDeleteButton();
            $form->disableViewButton();

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

    /**
     * 表单使用select时， options为url地址
     * @param Request $request
     */
    public function ApiCategories(Request $request)
    {
        $search = $request->get('q');
        $result = \App\Models\Category::query()
            ->where('is_directory', boolval($request->input('is_directory', true)))
            ->where('name', 'like', '%' . $search . '%')
            ->paginate();
        // 组装格式 [ { "id":1, "text":'a'}, {}]
        $result->setCollection($result->getCollection()->map(function (\App\Models\Category $category) {
            return ['id' => $category->id, 'text' => $category->full_name];
        }));

        return $result;
    }
}
