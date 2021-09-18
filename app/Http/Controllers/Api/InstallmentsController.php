<?php

namespace App\Http\Controllers\Api;

use App\Http\Requests\Api\PageRequest;
use App\Models\Installment;
use App\Models\User;
use Illuminate\Http\JsonResponse;

class InstallmentsController extends ApiBaseController
{
    /**
     * 分期付款列表
     *
     * @param PageRequest $request
     * @return JsonResponse
     */
    public function index(PageRequest $request): JsonResponse
    {
        $page = $request->input('page');
        $size = $request->input('size');
        /** @var User $user */
        $user = $this->userService->getUserInfoFromJwt();
        $installments = $this->installmentService->index($user);
        return $this->pageService->customPage($page, $size, $installments, 'installments');
    }

    /**
     * 分期付款详情
     *
     * @param Installment $installment
     * @return JsonResponse
     */
    public function show(Installment $installment): JsonResponse
    {
        return $this->installmentService->detail($installment);
    }

    /**
     * 分期支付宝回调
     *
     * @return string
     */
    public function installmentAliPayNotify()
    {
        return $this->installmentService->installmentAliPayNotify();
    }

    /**
     * 分期微信回调
     *
     * @return string
     */
    public function installmentWechatNotify()
    {
        return $this->installmentService->installmentWechatNotify();
    }

}
