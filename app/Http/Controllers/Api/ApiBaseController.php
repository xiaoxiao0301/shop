<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
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
     * @var PageServicesImpl
     */
    protected $pageService;

    /**
     * @var ProductServicesImpl
     */
    protected $productService;

    public function __construct()
    {
        $this->userService = new UserServicesImpl();
        $this->smsService = new SmsServicesImpl();
        $this->tokenService = new TokenServicesImpl();
        $this->pageService = new PageServicesImpl();
        $this->productService = new ProductServicesImpl();
    }


}
