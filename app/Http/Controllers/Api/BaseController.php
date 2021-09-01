<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\impl\SmsServicesImpl;
use App\Services\impl\TokenServicesImpl;
use App\Services\impl\UserServicesImpl;

class BaseController extends Controller
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

    public function __construct()
    {
        $this->userService = new UserServicesImpl();
        $this->smsService = new SmsServicesImpl();
        $this->tokenService = new TokenServicesImpl();
    }


}
