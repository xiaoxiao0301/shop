<?php

use App\Http\Controllers\Api\AuthorizationsController;
use App\Http\Controllers\Api\CartItemsController;
use App\Http\Controllers\Api\CouponsController;
use App\Http\Controllers\Api\FavoriteProductsController;
use App\Http\Controllers\Api\ProductsController;
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


    // 商品列表
    Route::get('products/{shopId?}', [ProductsController::class, 'index'])
        ->name('api.products.list');
    // 商品详情
    Route::get('products/{product}', [ProductsController::class, 'show'])
        ->name('api.product.show');

    // 店铺优惠券列表
    Route::get('coupons/{shopId}', [CouponsController::class, 'index'])
        ->name('api.shop.coupons');


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


        // |------------------------ 商品  ------------------------|
        // 收藏商品
        Route::post('products/{product}/favorite', [FavoriteProductsController::class, 'store'])
            ->name('api.product.favorite');
        // 取消收藏商品
        Route::delete('products/{product}/favorite', [FavoriteProductsController::class, 'destroy'])
            ->name('api.product.dis_favorite');
        // 收藏列表
        Route::get('favorites', [FavoriteProductsController::class, 'index'])
            ->name('api.product.favorite.list');


        // |------------------------ 购物车  ------------------------|
        // 购物车添加商品
        Route::post('cart', [CartItemsController::class, 'store'])
            ->name('api.cart.create');
        // 从购物车移除商品
        Route::delete('carts/{sku}', [CartItemsController::class, 'destroy'])
            ->name('api.cart.delete');
        // 购物车列表
        Route::get('carts', [CartItemsController::class, 'index'])
            ->name('api.carts.list');


        // |------------------------ 用户  ------------------------|
        // 领取优惠券
        Route::post('user/{couponId}/collect', [CouponsController::class, 'collectCoupon'])
            ->name('api.user.collect.coupon');
        // 优惠券列表
        Route::get('user/coupons', [UsersController::class, 'couponsList'])
            ->name('api.user.coupons.list');


    });



});


