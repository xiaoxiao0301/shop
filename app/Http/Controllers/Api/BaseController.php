<?php

namespace App\Http\Controllers\Api;

use App\dict\Codes;
use App\Http\Controllers\Controller;
use App\Services\impl\CartItemServiceImpl;
use App\Services\impl\CouponCodeServiceImpl;
use App\Services\impl\OrderServiceImpl;
use App\Services\impl\PageServiceImpl;
use App\Services\impl\ProductServicesImpl;
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


    /**
     * 购物车服务
     *
     * @var CartItemServiceImpl
     */
    public CartItemServiceImpl $cartItemService;

    /**
     * 订单服务
     *
     * @var OrderServiceImpl
     */
    public OrderServiceImpl $orderService;

    /**
     * 优惠券服务
     *
     * @var CouponCodeServiceImpl
     */
    public CouponCodeServiceImpl $couponCodeService;


    public function __construct()
    {
        $this->userService = new UserServiceImpl();
        $this->productService = new ProductServicesImpl();
        $this->pageService = new PageServiceImpl();
        $this->cartItemService = new CartItemServiceImpl();
        $this->orderService = new OrderServiceImpl();
        $this->couponCodeService = new CouponCodeServiceImpl();
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
