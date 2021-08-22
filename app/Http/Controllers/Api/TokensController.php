<?php

namespace App\Http\Controllers\Api;

use App\dict\Codes;
use App\Http\Controllers\Controller;
use App\Http\Requests\Api\TokenRequest;

class TokensController extends BaseController
{
    public function update(TokenRequest $request)
    {
        $refreshToken = auth()->refresh($request->token);
        return $this->responseData(Codes::CODE_SUCCESS,
            Codes::getMessageByCode(Codes::CODE_SUCCESS),
            [
                "token" => $refreshToken
            ],
            Codes::STATUS_CODE_OK
        );
    }
}
