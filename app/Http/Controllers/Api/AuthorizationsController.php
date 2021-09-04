<?php

namespace App\Http\Controllers\Api;

use App\Http\Requests\Api\AuthorizationRequest;
use Exception;
use Illuminate\Http\JsonResponse;
use OpenApi\Annotations\RequestBody;

class AuthorizationsController extends ApiBaseController
{
    /**
     * 发送短信验证码
     *
     * @OA\Post(
     *     path="/v1/code",
     *     operationId="code",
     *     tags={"用户"},
     *     summary="获取验证码",
     *     description="用户注册或登陆时输入手机号获取验证码",
     *     @RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             required={"phone"},
     *             @OA\Property(property="phone", type="string", format="phone")
     *         )
     *     ),
     *     @OA\Response(response=200, description="ok"),
     *
     * )
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
