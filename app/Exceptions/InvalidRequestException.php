<?php

namespace App\Exceptions;

use App\dict\Codes;
use Exception;
use Illuminate\Http\JsonResponse;

/**
 * 自定义参数异常
 */
class InvalidRequestException extends Exception
{
    /**
//     * @param \Illuminate\Http\Request $request
     * @return JsonResponse
     */
    public function render(): JsonResponse
    {
        return response()->json([
            "code" => Codes::CODE_INVALID_PARAM,
            "message" => $this->message,
            "data" => []
        ])->setStatusCode(Codes::STATUS_CODE_BAD_REQUEST);
    }
}
