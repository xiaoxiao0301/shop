<?php

namespace App\Services\impl;

use App\Dict\ResponseJsonData;
use App\Services\TokenServicesIf;
use Illuminate\Http\JsonResponse;

class TokenServicesImpl implements TokenServicesIf
{

    /**
     * 登陆用户生成token
     *
     * @param $user
     * @return JsonResponse
     */
    public function generateToken($user): JsonResponse
    {
        $token = auth()->fromUser($user);
        return ResponseJsonData::responseOk($this->makeTokenResponseData($token));
    }

    /**
     * 刷新token
     *
     * @param $token
     * @return JsonResponse
     */
    public function refreshToken($token): JsonResponse
    {
        $refreshToken = auth()->refresh(true, true);
        return ResponseJsonData::responseOk($this->makeTokenResponseData($refreshToken));
    }

    /**
     * 构造返回token值
     *
     * @param $token
     * @return array
     */
    protected function makeTokenResponseData($token): array
    {
        return [
            'token_type' => 'Bearer',
            'token' => $token,
            'expires_in' => auth()->factory()->getTTL() * 60,
        ];
    }
}
