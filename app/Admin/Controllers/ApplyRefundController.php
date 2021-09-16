<?php

namespace App\Admin\Controllers;

use App\Admin\Actions\Grid\AgreeUserApplyOrderRefund;
use App\Admin\Actions\Grid\DisAgreeUserApplyOrderRefund;
use App\Admin\Repositories\ApplyRefundRepositories;
use App\Exceptions\InternalBusyException;
use App\Models\Order;
use App\Services\impl\OrderServicesImpl;
use Dcat\Admin\Grid;
use Dcat\Admin\Http\Controllers\AdminController;
use Dcat\Admin\Http\JsonResponse;
use Dcat\Admin\Layout\Content;
use Illuminate\Http\Request;
use Log;

class ApplyRefundController extends AdminController
{
    public function applyRefundLists(Content $content)
    {
        return $content
            ->translation($this->translation())
            ->title('退款列表')
            ->description('退款申请列表')
            ->body($this->grid());
    }

    protected function grid()
    {
        return Grid::make(new ApplyRefundRepositories(), function (Grid $grid) {
            $grid->setActionClass(Grid\Displayers\Actions::class);
            $grid->model()->where('refund_status', Order::REFUND_STATUS_APPLIED)->orderBy('paid_at', 'desc');
            $grid->column('id')->sortable();
            $grid->column('order_no');
            $grid->column('user_id')->display(function ($value) {
                $user = \App\Models\User::where('user_id', $value)->first();
                return "{$user->name}|{$user->phone}";
            });
            $grid->column('total_amount','订单总额');
            $grid->column('status', '订单状态')->display(function ($value) {
                if ($this->closed) {
                    return '已关闭';
                } else if (!$this->closed && $this->paid_at) {
                    return '已支付';
                }
            });
            $grid->column('refund_status', '退款状态')->display(function ($value) {
                $extra = json_decode($this->extra, true);
                if ($value == Order::REFUND_STATUS_APPLIED) {
                    return Order::$refundStatusMap[$value] . ", 理由:" . $extra['refund_reason'];
                }
                return Order::$refundStatusMap[$value];
            });

            $grid->actions(function (Grid\Displayers\Actions $actions) {
                $actions->disableDelete();
                $actions->disableEdit();
                $actions->disableView();
                $actions->append(new AgreeUserApplyOrderRefund());
                $actions->append(new DisAgreeUserApplyOrderRefund());
            });


            $grid->filter(function (Grid\Filter $filter) {
                $filter->equal('id');
            });

            $grid->disableCreateButton();
            $grid->disableRowSelector();
            $grid->disableFilterButton();

        });
    }

    /**
     * 后台处理订单退款，暂时做支付宝
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function handleRefund(Request $request, OrderServicesImpl $orderService)
    {
        $data = $request->validate([
            'agree' => ['required', 'boolean'],
            'reason' => ['required_if:agree, false'],
            'order_id' => 'required'
        ]);
        $agree = $data['agree'];
        $orderId = $data['order_id'];
        $orderInfo = Order::find($orderId);
        if (!$agree) {
            // 拒绝退款
            // 将拒绝退款理由放到订单的 extra 字段中
            $extra = $orderInfo->extra ?: [];
            $extra['refund_disagree_reason'] = $data['reason'];
            $orderInfo->refund_status = Order::REFUND_STATUS_PENDING;
            $orderInfo->extra = $extra;
            $orderInfo->save();
        } else {
            $orderService->refundOrder($orderInfo);
        }
        return JsonResponse::make()->success('成功');
    }

}
