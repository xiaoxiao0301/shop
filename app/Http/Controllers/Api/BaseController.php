<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\impl\UserAddressServiceImpl;
use App\Services\impl\UserServciesImpl;
use Illuminate\Http\Request;

class BaseController extends Controller
{
    public $userSerivce;

    public $userAddressService;

    public function __construct()
    {
        $this->userSerivce = new UserServciesImpl();
        $this->userAddressService = new UserAddressServiceImpl();
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
    protected function responseData(int $code, string $message, array $data, int $statusCode)
    {
        return response()->json([
            'code' => $code,
            'message' => $message,
            'data' => $data
        ])->setStatusCode($statusCode);
    }

    /**
     * 计算分页每页的起止位置
     *
     * @param $page
     * @param $size
     */
    protected function calcPageStartAndEnd($page, $size)
    {
        $start = ($page - 1) * $size;
        $end = $start + $size;
        return [$start, $end];
    }
}
