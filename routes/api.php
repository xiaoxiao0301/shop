<?php

use App\Http\Controllers\Api\AuthorizationsController;
use App\Http\Controllers\Api\UserAddressesController;
use App\Http\Controllers\Api\UsersController;
use Illuminate\Support\Facades\Route;

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

// v1 版本的api接口
$version = "v1";
Route::prefix($version)->group(function () {
    // |---------------------------------------- 不用登陆就能访问的接口   ------------------------|

    // 注册，登陆获取验证码
    Route::post('code', [AuthorizationsController::class, 'code'])
        ->name('api.register.code');

    // 登陆
    Route::post('login', [UsersController::class, 'store'])
        ->name('api.user.login');

    // 刷新token
    Route::post('refresh-token', [UsersController::class, 'refreshToken'])
        ->name('api.refresh.token');

    // |----------------------------------------  需要登陆认证的接口   ------------------------|
    Route::middleware('auth')->group(function () {

        // |------------------------ 收货地址  ------------------------|
        // 添加收货地址
        Route::post('address', [UserAddressesController::class, 'store'])
            ->name('api.address.add');
        // 更新收货地址
        Route::put('address/{address}', [UserAddressesController::class, 'update'])
            ->name('api.address.edit');
        // 删除收货地址
        Route::delete('address/{address}', [UserAddressesController::class, 'destroy'])
            ->name('api.address.delete');
        // 收货地址列表
        Route::get('addresses', [UserAddressesController::class, 'index'])
            ->name('api.address.list');

    });
});


