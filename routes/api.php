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
    Route::post("captcha", "Api\CaptchasController@info")->name("api.captcha.info");
    // 短信验证码
    Route::post("code", "Api\VerificationCodesController@check")->name("api.captcha.check");
});



