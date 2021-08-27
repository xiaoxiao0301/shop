<?php

namespace App\Http\Controllers\Api;

use App\dict\Codes;
use App\Http\Controllers\Controller;
use App\Services\impl\PageServiceImpl;
use App\Services\impl\ProductServicesImpl;
use App\Services\impl\UserAddressServiceImpl;
use App\Services\impl\UserServiceImpl;
use Illuminate\Http\JsonResponse;

class BaseController extends Controller
{

    /**
     * 用户服务
     *
     * @var UserServiceImpl
     */
    public UserServiceImpl $userService;

    /**
     * 用户地址服务
     *
     * @var UserAddressServiceImpl
     */
    public UserAddressServiceImpl $userAddressService;

    /**
     * 商品服务
     *
     * @var ProductServicesImpl
     */
    public ProductServicesImpl $productService;

    /**
     * 分页服务
     *
     * @var PageServiceImpl
     */
    public PageServiceImpl $pageService;

    public function __construct()
    {
        $this->userService = new UserServiceImpl();
        $this->userAddressService = new UserAddressServiceImpl();
        $this->productService = new ProductServicesImpl();
        $this->pageService = new PageServiceImpl();
    }

    /**
     * 前端接口统一返回格式
     *
     * @param int $code
     * @param array $data
     * @param int $statusCode
     * @return JsonResponse
     */
    protected function responseData(int $code, array $data, int $statusCode): JsonResponse
    {
        return response()->json([
            'code' => $code,
            'message' => Codes::getMessageByCode($code),
            'data' => $data
        ])->setStatusCode($statusCode);
    }
}
