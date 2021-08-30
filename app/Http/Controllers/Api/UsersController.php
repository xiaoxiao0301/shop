<?php

namespace App\Http\Controllers\Api;



use App\dict\Codes;
use Illuminate\Http\JsonResponse;

class UsersController extends BaseController
{
    /**
     * 所有未读消息列表
     *
     * @return JsonResponse
     */
    public function notificationLists()
    {
        $lists = $this->userService->getUserUnreadNotificationLists();
        $result = [];
        foreach ($lists as $list) {
            $result[] = $list->data;
        }
        return $this->responseData(Codes::CODE_SUCCESS, $result, Codes::STATUS_CODE_OK);
    }

    /**
     * 标记所有未读消息为已读
     *
     * @return JsonResponse
     */
    public function readAll(): JsonResponse
    {
        $this->userService->makeUserNotificationReadAll();
        return $this->responseData(Codes::CODE_SUCCESS, [], Codes::STATUS_CODE_OK);
    }
}
