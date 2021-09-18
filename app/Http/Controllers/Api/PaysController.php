<?php

namespace App\Http\Controllers\Api;

use App\Dict\ResponseJsonData;
use App\Exceptions\InvalidRequestException;
use App\Http\Requests\Api\InstallmentOrderRequest;
use App\Http\Requests\Api\PayRequest;
use App\Models\Installment;
use App\Models\Order;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\Routing\ResponseFactory;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class PaysController extends ApiBaseController
{

    /**
     * 支付订单
     *
     * @param PayRequest $request
     * @return mixed
     * @throws InvalidRequestException
     */
    public function pay(PayRequest $request)
    {
        $user = $this->userService->getUserInfoFromJwt();
        $data = $request->all();
        return $this->payService->orderPay($user, $data);
    }


    /**
     * 分期订单
     *
     * @param Order $order
     * @param InstallmentOrderRequest $request
     * @return JsonResponse
     * @throws InvalidRequestException
     */
    public function payByInstallment(Order $order, InstallmentOrderRequest $request): JsonResponse
    {
        try {
            $this->authorize('show', $order);
            $count = $request->input('count');
            $user = $this->userService->getUserInfoFromJwt();
            return $this->payService->createPayInstallment($order, $user, $count);
        } catch (AuthorizationException $exception) {
            return ResponseJsonData::responseUnAuthorization("无权限执行");
        }
    }

    /**
     * 支付宝分期支付
     *
     * @param Installment $installment
     * @return Application|ResponseFactory|Response
     * @throws InvalidRequestException
     */
    public function installmentAliPay(Installment $installment)
    {
        return $this->payService->installmentOrderPayByAli($installment);
    }

    /**
     * 微信分期支付
     *
     * @param Installment $installment
     * @return Application|ResponseFactory|Response
     * @throws InvalidRequestException
     */
    public function installmentWechatPay(Installment $installment)
    {
        return $this->payService->installmentWechatPay($installment);
    }

}
