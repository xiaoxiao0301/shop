<?php

namespace App\Admin\Controllers;

use App\Jobs\SyncOneProductToES;
use App\Models\Category;
use App\Models\Product;
use App\Models\ProductSku;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Http\Controllers\AdminController;
use Dcat\Admin\Layout\Content;
use Illuminate\Support\Facades\Redis;
use Log;

abstract class CommonProductsController extends AdminController
{
    // 定义一个抽象方法，返回当前管理的商品类型
    abstract public function getProductType();

    public function index(Content $content)
    {
        return $content
            ->header(Product::$typeMap[$this->getProductType()].'列表')
            ->body($this->grid());
    }

    public function edit($id, Content $content)
    {
        return $content
            ->header('编辑'.Product::$typeMap[$this->getProductType()])
            ->body($this->form()->edit($id));
    }

    public function create(Content $content)
    {
        return $content
            ->header('创建'.Product::$typeMap[$this->getProductType()])
            ->body($this->form());
    }

    protected function grid()
    {
        return Grid::make(new Product(), function (Grid $grid) {
            $grid->setActionClass(Grid\Displayers\Actions::class);
            // 筛选出当前类型的商品，默认 ID 倒序排序
            $grid->model()->where('type', $this->getProductType())->orderBy('id', 'desc');
            // 调用自定义方法
            $this->customGrid($grid);

            // 开启弹窗创建表单
//            $grid->enableDialogCreate();
            // 设置弹窗的宽，高
//            $grid->setDialogFormDimensions('65%', '75%');

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

    // 定义一个抽象方法，各个类型的控制器将实现本方法来定义列表应该展示哪些字段
    abstract protected function customGrid(Grid $grid);

    protected function form()
    {
        return Form::make(Product::with(['seckill','crowdfunding','skus','properties']), function (Form $form) {
            $form->display('id');
            //  在表单页面中添加一个名为 type 的隐藏字段，值为当前商品类型
            $form->hidden('type')->value($this->getProductType());
            $form->text('title', '商品名称')->rules('required');
            $form->text('long_title', '商品长标题')->rules('required');
            // 添加一个类目字段，与之前类目管理类似，使用 Ajax 的方式来搜索添加
            $form->select('category_id', '类目')->options(function ($id) {
                $category = Category::find($id);
                if ($category) {
                    return [$category->id => $category->full_name];
                }
            })->ajax('api/categories?is_directory=0');
            $form->image('image', '封面图片')->autoUpload()->rules('required')->removable(false)->uniqueName();
            $form->editor('description', '商品描述')->rules('required');
            $form->switch('on_sale', '上架')->default(false);

            $this->customForm($form);

            // 第一个参数必须和主模型中定义此关联关系的方法同名
            $form->hasMany('skus', 'SKU列表', function (Form\NestedForm $form) {
                $form->text('title', 'SKU名称')->rules('required');
                $form->text('description', 'SKU描述')->rules('required');
                $form->text('price', '单价')->rules('required|numeric|min:0.01');
                $form->text('stock', '库存')->rules('required|integer|min:0');
            });

            $form->hasMany('properties', '商品属性', function (Form\NestedForm $form) {
                $form->text('name', '属性名')->rules('required');
                $form->text('value', '属性值')->rules('required');
            });

            // 修改模型中的数据需要配合隐藏表单使用
            $form->hidden('price');
            $form->saving(function (Form $form) {
                $form->price = collect($form->input('skus'))->where(Form::REMOVE_FLAG_NAME, 0)->min('price') ?: 0;
            });

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

    // 定义一个抽象方法，各个类型的控制器将实现本方法来定义表单应该有哪些额外的字段
    abstract protected function customForm(Form $form);

}
