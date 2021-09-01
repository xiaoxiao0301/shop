<?php

namespace App\Exceptions;

use App\Dict\ResponseJsonData;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

/**
 * 服务器内部错误
 */
class InternalBusyException extends Exception
{
    /**
     * 渲染异常为 HTTP 响应
     * @param Request $request
     * @return JsonResponse
     */
    public function render(Request $request): JsonResponse
    {
        return ResponseJsonData::responseInternal();
    }
}
