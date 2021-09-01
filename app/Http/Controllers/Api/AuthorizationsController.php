<?php

namespace App\Http\Controllers\Api;

use App\Http\Requests\Api\AuthorizationRequest;
use Exception;
use Illuminate\Http\JsonResponse;

class AuthorizationsController extends BaseController
{
    /**
     * 发送短信验证码
     *
     * @param AuthorizationRequest $request
     * @return JsonResponse
     * @throws Exception
     */
    public function code(AuthorizationRequest $request): JsonResponse
    {
        $phone = $request->input('phone');
        return $this->smsService->sendCode($phone);
    }
}
