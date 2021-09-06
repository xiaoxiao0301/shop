<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\impl\CouponServicesImpl;
use App\Services\impl\OrderServicesImpl;
use App\Services\impl\PageServicesImpl;
use App\Services\impl\ProductServicesImpl;
use App\Services\impl\SmsServicesImpl;
use App\Services\impl\TokenServicesImpl;
use App\Services\impl\UserServicesImpl;

/**
 * Class BaseController
 *
 * @package App\Http\Controllers\Api
 *
 * @OA\Info (
 *     title="电商Api",
 *     description="Laravel8 Shop Api Docs",
 *     version="1.0.0",
 * )
 *
 * @OA\Server(
 *      url="http://local.shop.cn/api",
 *      description="Shop OpenApi Server"
 * )
 *
 */
class ApiBaseController extends Controller
{
    /**
     * 用户
     *
     * @var UserServicesImpl
     */
    protected $userService;

    /**
     * 短信
     *
     * @var SmsServicesImpl
     */
    protected $smsService;

    /**
     * jwt-token
     *
     * @var TokenServicesImpl
     */
    protected $tokenService;

    /**
     * 分页
     *
     * @var PageServicesImpl
     */
    protected $pageService;

    /**
     * 商品
     *
     * @var ProductServicesImpl
     */
    protected $productService;

    /**
     * 优惠券
     *
     * @var CouponServicesImpl
     */
    protected $couponService;


    /**
     * 订单
     *
     * @var OrderServicesImpl
     */
    protected $orderService;


    public function __construct()
    {
        $this->userService = new UserServicesImpl();
        $this->smsService = new SmsServicesImpl();
        $this->tokenService = new TokenServicesImpl();
        $this->pageService = new PageServicesImpl();
        $this->productService = new ProductServicesImpl();
        $this->couponService = new CouponServicesImpl();
        $this->orderService = new OrderServicesImpl();
    }


}
