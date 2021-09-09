<?php

namespace App\Http\Controllers\Api;

use App\Dict\ResponseJsonData;
use App\Exceptions\InvalidRequestException;
use App\Http\Requests\Api\RefreshTokenRequest;
use App\Http\Requests\Api\UserRequest;
use App\Models\Order;
use Illuminate\Http\JsonResponse;

class UsersController extends ApiBaseController
{
    /**
     * 注册/登陆
     *
     * @param UserRequest $request
     * @return JsonResponse
     * @throws InvalidRequestException
     */
    public function store(UserRequest $request): JsonResponse
    {
        $data = $request->all();
        $user = $this->userService->checkLoginCode($data);
        return $this->tokenService->generateToken($user);
    }


    /**
     * 刷新token
     *
     * @param RefreshTokenRequest $request
     * @return JsonResponse
     */
    public function refreshToken(RefreshTokenRequest $request): JsonResponse
    {
        $token = $request->input('token');
        return $this->tokenService->refreshToken($token);
    }


    /**
     * 已领取优惠券列表
     *
     * @return JsonResponse
     */
    public function couponsList(): JsonResponse
    {
        $coupons = $this->userService->couponLists();
        return ResponseJsonData::responseOk($coupons);
    }


    /**
     * 获取所有未读消息列表
     *
     * @return JsonResponse
     */
    public function notificationLists(): JsonResponse
    {
        $lists = $this->userService->getNotificationsLists();
        $result = [];
        foreach ($lists as $list) {
            $result[] = $list->data;
        }
        return ResponseJsonData::responseOk($result);
    }


    /**
     * 标记未读消息为已读
     *
     * @return JsonResponse
     */
    public function makeNotificationAsRead(): JsonResponse
    {
        $this->userService->readAllNotifications();
        return ResponseJsonData::responseOk();
    }
}
