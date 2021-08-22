<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\impl\UserServciesImpl;
use Illuminate\Http\Request;

class BaseController extends Controller
{
    public $userSerivce;

    public function __construct()
    {
        $this->userSerivce = new UserServciesImpl();
    }

    /**
     * 前端接口统一返回格式
     *
     * @param int $code
     * @param string $message
     * @param array $data
     * @param int $statusCode
     * @return \Illuminate\Http\JsonResponse
     */
    public function responseData(int $code, string $message, array $data, int $statusCode)
    {
        return response()->json([
            'code' => $code,
            'message' => $message,
            'data' => $data
        ])->setStatusCode($statusCode);
    }
}
