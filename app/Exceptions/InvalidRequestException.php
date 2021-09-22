<?php

namespace App\Exceptions;

use App\Dict\ResponseJsonData;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

/**
 * 用户提交参数出错和校验规则出错
 */
class InvalidRequestException extends Exception
{

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function render(Request $request):JsonResponse
    {
        return ResponseJsonData::responseUnProcessAble($this->message, $this->getCode());
    }
}
