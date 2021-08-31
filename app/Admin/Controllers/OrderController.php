<?php

namespace App\Admin\Controllers;

use App\Admin\Repositories\Order;
use App\dict\OrderDict;
use App\Exceptions\InternalException;
use App\Exceptions\InvalidRequestException;
use App\Models\User;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Http\JsonResponse;
use Dcat\Admin\Layout\Content;
use Dcat\Admin\Show;
use Dcat\Admin\Http\Controllers\AdminController;
use Illuminate\Http\Request;

class OrderController extends AdminController
{
    protected $title = "订单管理";

    protected $description = [
        'index' => '订单列表',
        'show' => '订单详情',
    ];

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        return Grid::make(new Order(), function (Grid $grid) {
            $grid->setActionClass(Grid\Displayers\Actions::class);

            // 只展示已支付的订单，并且默认按支付时间倒序排序
            $grid->model()->whereNotNull('paid_at')->orderBy('paid_at', 'desc');
            $grid->column('id')->sortable();
            $grid->column('order_no');
            $grid->column('user_id','买家')->display(function ($value) {
                $user = User::where('user_id', $value)->first();
                return "{$user->name}|{$user->phone}";
            });
//            $grid->column('address');
            $grid->column('total_amount');
//            $grid->column('remark');
//            $grid->column('paid_at');
//            $grid->column('payment_method');
//            $grid->column('payment_no');
            $grid->column('refund_status')->display(function($value) {
                return OrderDict::$refundStatusMap[$value];
            });
//            $grid->column('refund_no');
//            $grid->column('closed');
//            $grid->column('reviewed');
            $grid->column('ship_status')->display(function ($value) {
                return OrderDict::$shipStatusMap[$value];
            });
//            $grid->column('ship_data');
//            $grid->column('extra');
//            $grid->column('created_at');
//            $grid->column('updated_at')->sortable();

            $grid->filter(function (Grid\Filter $filter) {
                $filter->equal('id');

            });

            $grid->disableRowSelector();

            $grid->disableFilterButton();
            $grid->disableCreateButton();
            $grid->disableEditButton();
            $grid->disableDeleteButton();

            $grid->tools(function ($tools) {
                // 禁用批量删除按钮
                $tools->batch(function ($batch) {
                    $batch->disableDelete();
                });
            });

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
        return Show::make($id, new Order(), function (Show $show) {
            $show->field('id');
            $show->field('order_no');
            $show->field('user_id');
            $show->field('address');
            $show->field('total_amount');
            $show->field('remark');
            $show->field('paid_at');
            $show->field('payment_method');
            $show->field('payment_no');
            $show->field('refund_status');
            $show->field('refund_no');
            $show->field('closed');
            $show->field('reviewed');
            $show->field('ship_status');
            $show->field('ship_data');
            $show->field('extra');
            $show->field('created_at');
            $show->field('updated_at');
        });
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        return Form::make(new Order(), function (Form $form) {
            $form->display('id');
            $form->text('order_no');
            $form->text('user_id');
            $form->text('address');
            $form->text('total_amount');
            $form->text('remark');
            $form->text('paid_at');
            $form->text('payment_method');
            $form->text('payment_no');
            $form->text('refund_status');
            $form->text('refund_no');
            $form->text('closed');
            $form->text('reviewed');
            $form->text('ship_status');
            $form->text('ship_data');
            $form->text('extra');

            $form->display('created_at');
            $form->display('updated_at');
        });
    }

    /**
     * 订单详情
     *
     * @param mixed $id
     * @param Content $content
     * @return Content
     */
    public function show($id, Content $content)
    {
        $order = \App\Models\Order::find($id);
        return $content
            ->translation($this->translation())
            ->title($this->title())
            ->description($this->description()['show'] ?? trans('admin.show'))
            ->body(view('admin.orders.show', compact('order')));
    }

    /**
     * 订单发货
     *
     * @param \App\Models\Order $order
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse
     * @throws InvalidRequestException
     */
    public function ship(\App\Models\Order $order, Request $request)
    {
        if (!$order->paid_at) {
            throw new InvalidRequestException('该订单未付款');
        }

        if ($order->ship_status !== OrderDict::SHIP_STATUS_PENDING) {
            throw new InvalidRequestException('订单已发货');
        }

        $data = $request->validate([
            'express_company' => ['required'],
            'express_no'      => ['required'],
        ], [
            'express_company.required' => '物流公司不能为空',
            'express_no.required' => '物流单号不能为空',
        ]);

        $order->update([
            'ship_status' => OrderDict::SHIP_STATUS_DELIVERED,
            'ship_data' => $data
        ]);

        return redirect()->back();
    }


    public function handleRefund(\App\Models\Order $order, Request $request)
    {
        $data = $request->validate([
            'agree' => ['required', 'boolean'],
            'reason' => ['required_if:agree, false']
        ]);
        // 判断订单状态是否正确
        if ($order->refund_status !== OrderDict::REFUND_STATUS_APPLIED) {
            throw new InvalidRequestException('订单状态不正确');
        }

        if ($data['agree']) {
            // 同意退款
            $this->_refundOrder($order);
        } else {
            // 拒绝退款
            // 将拒绝退款理由放到订单的 extra 字段中
            $extra = $order->extra ?: [];
            $extra['refund_disagree_reason'] = $data['reason'];
            // 将订单的退款状态改为未退款
            $order->update([
                'refund_status' => OrderDict::REFUND_STATUS_PENDING,
                'extra'         => $extra,
            ]);
        }

        return JsonResponse::make()->success('成功');
    }

    public function _refundOrder(\App\Models\Order $order)
    {
        switch ($order->payment_method) {
            case 'alipay':
                $refundNo = \App\Models\Order::generateOrderRefundStringNumber();
                $ret = app('alipay')->refund([
                    'out_trade_no' => $order->order_no, // 之前的订单流水号
                    'refund_amount' => $order->total_amount, // 退款金额，单位元
                    'out_request_no' => $refundNo, // 退款订单号
                ]);
                // 根据支付宝的文档，如果返回值里有 sub_code 字段说明退款失败
                if ($ret->sub_code) {
                    // 将退款失败的保存存入 extra 字段
                    $extra = $order->extra;
                    $extra['refund_failed_code'] = $ret->sub_code;
                    // 将订单的退款状态标记为退款失败
                    $order->update([
                        'refund_no' => $refundNo,
                        'refund_status' => OrderDict::REFUND_STATUS_FAILED,
                        'extra' => $extra,
                    ]);
                } else {
                    // 将订单的退款状态标记为退款成功并保存退款订单号
                    $order->update([
                        'refund_no' => $refundNo,
                        'refund_status' => OrderDict::REFUND_STATUS_SUCCESS,
                    ]);
                }
                break;
            case 'wechat':
                // 生成退款订单号
                $refundNo = \App\Models\Order::generateOrderRefundStringNumber();
                app('wechat_pay')->refund([
                    'out_trade_no' => $order->order_no, // 之前的订单流水号
                    'total_fee' => $order->total_amount * 100, //原订单金额，单位分
                    'refund_fee' => $order->total_amount * 100, // 要退款的订单金额，单位分
                    'out_refund_no' => $refundNo, // 退款订单号
                    // 微信支付的退款结果并不是实时返回的，而是通过退款回调来通知，因此这里需要配上退款回调接口地址
                    'notify_url' => route('api.payment.wechat.refund.notify')
                ]);
                // 将订单状态改成退款中
                $order->update([
                    'refund_no' => $refundNo,
                    'refund_status' => OrderDict::REFUND_STATUS_PROCESSING,
                ]);
                break;
            default:
                throw new InternalException('未知订单支付方式' . $order->payment_method);
        }
    }

}
