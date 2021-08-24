<?php

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

$version = "v1";

Route::prefix($version)->group(function () {

    // 获取验证码
    Route::post("captcha", "Api\CaptchasController@info")
        ->name("api.captcha.info");
    // 短信验证码
    Route::post("code", "Api\VerificationCodesController@check")
        ->name("api.captcha.check");
    // 注册
    Route::post("register", "Api\AuthorationsController@store")
        ->name('api.user.register');

    // new-register contains login
    Route::post("auth-code", "Api\AuthorationsController@authCode")
        ->name("api.user.code");
    Route::post("auth-login", "Api\AuthorationsController@store")
        ->name("api.uer.login");
    // 刷新token
    Route::post("auth-refresh", "Api\TokensController@update")
        ->name("api.token.update");

    // 需要登陆后才能访问的路由
    Route::middleware('auth')->group(function () {

        // 收货列表
        Route::get('addresses', "Api\UserAddressesController@list")
            ->name("api.user.address.list");
        // 创建收货地址
        Route::post("address", "Api\UserAddressesController@store")
            ->name("api.user.address.create");
        Route::put("address/{address}", "Api\UserAddressesController@update")
            ->name("api.user.address.update");
        Route::delete('address/{address}', "Api\UserAddressesController@destroy")
            ->name("api.user.address.delete");
    });

});



