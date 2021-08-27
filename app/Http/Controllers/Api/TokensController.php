<?php

namespace App\Http\Controllers\Api;

use App\dict\Codes;
use App\Http\Requests\Api\TokenRequest;
use Illuminate\Http\JsonResponse;

class TokensController extends BaseController
{
    /**
     * 刷新用户的token
     *
     * @param TokenRequest $request
     * @return JsonResponse
     */
    public function update(TokenRequest $request): JsonResponse
    {
        $refreshToken = auth()->refresh($request->get('token'));
        return $this->responseData(Codes::CODE_SUCCESS,
            [
                "token" => $refreshToken
            ],
            Codes::STATUS_CODE_OK
        );
    }
}
