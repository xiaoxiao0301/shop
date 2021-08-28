<?php

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the 'api' middleware group. Enjoy building your API!
|
*/

$version = 'v1';

Route::prefix($version)->group(function () {

    Route::get('test', function () {
       throw new \App\Exceptions\InvalidRequestException("你好", 500);
    });

    // 获取验证码
    Route::post('captcha', 'Api\CaptchasController@info')
        ->name('api.captcha.info');
    // 短信验证码
    Route::post('code', 'Api\VerificationCodesController@check')
        ->name('api.captcha.check');
    // 注册
    Route::post('register', 'Api\AuthorizationsController@store')
        ->name('api.user.register');

    // new-register contains login
    Route::post('auth-code', 'Api\AuthorizationsController@authCode')
        ->name('api.user.code');
    Route::post('auth-login', 'Api\AuthorizationsController@store')
        ->name('api.uer.login');
    // 刷新token
    Route::post('auth-refresh', 'Api\TokensController@update')
        ->name('api.token.update');

    // 需要登陆后才能访问的路由
    Route::middleware('auth')->group(function () {

        // |----------------------- 收货地址
        // 收货列表
        Route::get('addresses', 'Api\UserAddressesController@list')
            ->name('api.address.list');
        // 创建收货地址
        Route::post('address', 'Api\UserAddressesController@store')
            ->name('api.address.create');
        // 编辑
        Route::put('address/{address}', 'Api\UserAddressesController@update')
            ->name('api.address.update');
        // 删除
        Route::delete('address/{address}', 'Api\UserAddressesController@destroy')
            ->name('api.address.delete');

        // |----------------------- 收藏商品
        // 收藏商品
        Route::post('products/{product}/favorite', 'Api\ProductsController@favor')
            ->name('api.favorite.product');
        // 取消收藏商品
        Route::delete('products/{product}/favorite', 'Api\ProductsController@disfavor')
            ->name('api.disFavorite.product');
        // 收藏商品列表
        Route::get('products/favorite', 'Api\ProductsController@favoriteList')
            ->name('api.favorite.product.list');

        // |----------------------- 购物车
        // 添加商品
        Route::post('cart', 'Api\CartController@store')
            ->name('api.carts.add');
        // 列表
        Route::get('carts', 'Api\CartController@list')
            ->name('api.carts.list');
        // 移除商品
        Route::delete('carts/{sku}', 'Api\CartController@destroy')
            ->name('api.carts.delete');

        // |----------------------- 订单
        // 创建订单
        Route::post('orders', 'Api\OrdersController@store')
            ->name('api.orders.create');
        // 订单列表
        Route::get('orders', 'Api\OrdersController@list')
            ->name('api.orders.list');
        Route::get('orders/{order}', 'Api\OrdersController@show')
            ->name('api.orders.show');

    });


    // 商品列表
    Route::get('products', 'Api\ProductsController@list')
        ->name('api.products.list');
    // 商品详情
    Route::get('products/{product}', 'Api\ProductsController@show')
        ->name('api.product.show');

});



