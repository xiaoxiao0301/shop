<?php

namespace App\Exceptions;

use App\dict\Codes;
use Exception;
use Illuminate\Http\JsonResponse;

/**
 * 自定义系统异常返回
 */
class InternalException extends Exception
{
    /**
     * @return JsonResponse
     */
    public function render(): JsonResponse
    {
        return response()->json([
            "code" => Codes::CODE_NETWORK_BUSY,
            "message" => $this->message,
            "data" => []
        ])->setStatusCode(Codes::STATUS_CODE_ERROR_INTERNAL);
    }
}
