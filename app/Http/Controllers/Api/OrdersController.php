<?php

namespace App\Http\Controllers\Api;


use App\Dict\ResponseJsonData;
use App\Exceptions\InvalidRequestException;
use App\Http\Requests\Api\ApplyRefundRequest;
use App\Http\Requests\Api\OrderRequest;
use App\Http\Requests\Api\PageRequest;
use App\Http\Requests\Api\SendReviewRequest;
use App\Models\Coupon;
use App\Models\Order;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Http\JsonResponse;
use Throwable;

class OrdersController extends ApiBaseController
{
    /**
     * 创建订单
     *
     * @param OrderRequest $request
     * @return JsonResponse
     */
    public function store(OrderRequest $request): JsonResponse
    {
        $user = $this->userService->getUserInfoFromJwt();
        // 有一个去支付的按钮需要将订单信息返回
        $couponId = $request->input('coupon_id');
        $coupon = null;
        if (!is_null($couponId)) {
            $coupon = Coupon::find($couponId);
        }
        return $this->orderService->createOrder($user, $request->except(['coupon_id']), $coupon);
    }


    /**
     * 订单列表
     *
     * @param PageRequest $request
     * @return JsonResponse
     */
    public function index(PageRequest $request): JsonResponse
    {
        $page = $request->input('page');
        $size = $request->input('size');
        $user = $this->userService->getUserInfoFromJwt();
        $orders = $this->orderService->orderLists($user);
        return $this->pageService->customPage($page, $size, $orders, 'orders');
    }

    /**
     * 订单详情
     *
     * @param Order $order
     * @return JsonResponse
     */
    public function show(Order $order): JsonResponse
    {
        try {
            $this->authorize('show', $order);
            return $this->orderService->orderDetail($order);
        } catch (AuthorizationException $exception) {
            return ResponseJsonData::responseUnAuthorization("无权限执行");
        }

    }

    /**
     * 确认收货
     *
     * @param Order $order
     * @return JsonResponse
     * @throws InvalidRequestException
     */
    public function received(Order $order): JsonResponse
    {
        try {
            $this->authorize('show', $order);
            $this->orderService->receivedOrder($order);
            return ResponseJsonData::responseOk();
        } catch (AuthorizationException $exception) {
            return ResponseJsonData::responseUnAuthorization("无权限执行");
        }
    }

    /**
     * 订单评价
     *
     * @param Order $order
     * @param SendReviewRequest $request
     * @return JsonResponse
     * @throws InvalidRequestException
     * @throws Throwable
     */
    public function review(Order $order, SendReviewRequest $request): JsonResponse
    {
        try {
            $this->authorize('show', $order);
            return $this->orderService->reviewOrder($order, $request->input('reviews'));
        } catch (AuthorizationException $exception) {
            return ResponseJsonData::responseUnAuthorization("无权限执行");
        }
    }


    /**
     * 订单列表查看评价详情
     *
     * @param Order $order
     * @return JsonResponse
     * @throws InvalidRequestException
     */
    public function reviewDetail(Order $order): JsonResponse
    {
        try {
            $this->authorize('show', $order);

            $reviews = $this->orderService->orderReviewDetail($order);
            return ResponseJsonData::responseOk($reviews);
        } catch (AuthorizationException $exception) {
            return ResponseJsonData::responseUnAuthorization("无权限执行");
        }
    }


    /**
     * 申请退款
     *
     * @param Order $order
     * @param ApplyRefundRequest $request
     * @return JsonResponse|void
     * @throws InvalidRequestException
     */
    public function applyRefund(Order $order, ApplyRefundRequest $request): JsonResponse
    {
        try {
            $this->authorize('show', $order);
            $reason = $request->input('reason');
            $this->orderService->applyOrderRefund($order, $reason);
            return ResponseJsonData::responseOk();
        } catch (AuthorizationException $exception) {
            return ResponseJsonData::responseUnAuthorization("无权限执行");
        }
    }

}
