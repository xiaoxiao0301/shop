<?php

namespace App\Http\Controllers\Api;


use App\dict\Codes;
use App\dict\OrderDict;
use App\Http\Requests\Api\OrderRequest;
use App\Http\Requests\Api\PageRequest;
use App\Jobs\CloseOrderJob;
use App\Models\Order;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Http\JsonResponse;
use Throwable;

class OrdersController extends BaseController
{

    /**
     * 生成订单
     *
     * @param OrderRequest $request
     * @return JsonResponse
     * @throws Throwable
     */
    public function store(OrderRequest $request): JsonResponse
    {
        // postman post方式传递数组 body row json格式
        // postman post方式传递数组 body form-data 不需要写单引号
        $user = $this->userService->getCurrentUserInfo();
        $data = $request->all();
        $order = $this->orderService->createOrder($user, $data);
        // 订单未支付关闭
        $this->dispatch(new CloseOrderJob($order, OrderDict::ORDER_SHOULD_CLOSE_TTL));
        return $this->responseData(Codes::CODE_SUCCESS, [], Codes::STATUS_CODE_OK);
    }

    /**
     * 订单列表
     *
     * @param PageRequest $request
     * @return JsonResponse
     */
    public function list(PageRequest $request): JsonResponse
    {
        $page = $request->get('page');
        $size = $request->get('size');
        $user = $this->userService->getCurrentUserInfo();
        $orders = $this->orderService->orderListsByUser($user);
        $result = $this->pageService->customPage($page, $size, $orders->toArray());
        if (!$result["data"]) {
            $httpCode = Codes::STATUS_CODE_NOT_FOUND;
        } else {
            $httpCode = Codes::STATUS_CODE_OK;
        }

        return $this->responseData(Codes::CODE_SUCCESS, $result, $httpCode);
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
            $order = $order->load(['items.product', 'items.productSku']);
            return $this->responseData(Codes::CODE_SUCCESS, $order->toArray(), Codes::STATUS_CODE_OK);
        } catch (AuthorizationException $exception) {
            return $this->responseData(Codes::CODE_ACTION_NOT_ALLOWED, [], Codes::STATUS_CODE_FORBIDDEN);
        }
    }


}
