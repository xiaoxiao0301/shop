<?php

namespace App\Http\Controllers\Api;

use App\Exceptions\InvalidRequestException;
use App\Http\Requests\Api\RefreshTokenRequest;
use App\Http\Requests\Api\UserRequest;
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
}
