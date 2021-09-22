<?php

use App\Http\Controllers\Api\AuthorizationsController;
use App\Http\Controllers\Api\CartItemsController;
use App\Http\Controllers\Api\CategoriesController;
use App\Http\Controllers\Api\CouponsController;
use App\Http\Controllers\Api\CrowdFundingOrderController;
use App\Http\Controllers\Api\FavoriteProductsController;
use App\Http\Controllers\Api\InstallmentsController;
use App\Http\Controllers\Api\OrdersController;
use App\Http\Controllers\Api\PaysController;
use App\Http\Controllers\Api\ProductsController;
use App\Http\Controllers\Api\SeckillController;
use App\Http\Controllers\Api\UserAddressesController;
use App\Http\Controllers\Api\UsersController;
use App\Models\User;
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

    // |------------------------ 秒杀  ------------------------|
    // 优化秒杀接口，将身份认证放到最后去做
    Route::post('seckill_orders', [SeckillController::class, 'store'])
        ->name('api.seckill.order.create')->middleware('random_drop:80');

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


    // 商品分类列表
    Route::get('categories', [CategoriesController::class, 'getCategoryTree'])
        ->name('api.category.list');

    // 商品列表
    Route::get('products/{shopId?}', [ProductsController::class, 'index'])
        ->name('api.products.list');
    // 商品详情
    Route::get('products/{product}/detail', [ProductsController::class, 'show'])
        ->name('api.product.show');

    // 店铺优惠券列表
    Route::get('coupons/{shopId}', [CouponsController::class, 'index'])
        ->name('api.shop.coupons');

    // 支付宝服务器端回调
    Route::post('alipay/notify', [OrdersController::class, 'aliPayNotify'])
        ->name('api.alipay.notify');
    // 微信支付回调
    Route::post('wechat/notify', [OrdersController::class, 'wechatPayNotify'])
        ->name('api.wechat.notify');
    // 支付宝分期支付回调
    Route::post('installment/alipay/notify', [InstallmentsController::class, 'installmentAliPayNotify'])
        ->name('installment.alipay.notify');
    // 微信分期支付回调
    Route::post('installment/wechat/notify', [InstallmentsController::class, 'installmentWechatNotify'])
        ->name('installment.wechat.notify');

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
        // 未读消息列表
        Route::get('user/notifications', [UsersController::class, 'notificationLists'])
            ->name('api.user.notifications');
        // 标记已读
        Route::post('user/notifications/read', [UsersController::class, 'makeNotificationAsRead'])
            ->name('api.user.read.notification');


        // |------------------------ 订单  ------------------------|
        // 创建订单
        Route::post('order', [OrdersController::class, 'store'])
            ->name('api.order.create');
        // 订单列表
        Route::get('orders', [OrdersController::class, 'index'])
            ->name('api.orders.list');
        // 订单详情
        Route::get('orders/{order}', [OrdersController::class, 'show'])
            ->name('api.order.show');
        // 确认收货
        Route::post('orders/{order}/received', [OrdersController::class, 'received'])
            ->name('api.order.user.received');
        // 评价
        Route::post('orders/{order}/review', [OrdersController::class, 'review'])
            ->name('api.order.user.review');
        // 订单列表-查看评价
        Route::get('orders/{order}/review', [OrdersController::class, 'reviewDetail'])
            ->name('api.order.review.sho');
        // 申请退款
        Route::post('orders/{order}/apply_refund', [OrdersController::class, 'applyRefund'])
            ->name('api.order.apply.refund');


        // |------------------------ 支付  ------------------------|
        // 订单支付
        Route::post('order/pay', [PaysController::class, 'pay'])
            ->name('api.order.pay');
        // 支付宝前端回调
        Route::get('alipay/return', [OrdersController::class, 'aliPayReturn'])
            ->name('api.alipay.return');
        // 分期付款订单
        Route::post('payment/{order}/installment', [PaysController::class, 'payByInstallment'])
            ->name('api.payment.installment');

        // |------------------------ 众筹  ------------------------|
        Route::post('crowdfunding_order', [CrowdFundingOrderController::class, 'store'])
            ->name('api.crowdfunding.order.create');


        // |------------------------ 分期付款  ------------------------|
        //分期付款列表
        Route::get('installments', [InstallmentsController::class, 'index'])
            ->name('api.installments.list');
        // 分期付款详情
        Route::get('installments/{installment}', [InstallmentsController::class, 'show'])
            ->name('api.installment.detail');
        // 支付宝支付
        Route::post('installments/{installment}/alipay', [PaysController::class, 'installmentAliPay'])
            ->name('api.installment.pay.alipay');
        // 微信支付
        Route::post('installments/{installment}/wechat', [PaysController::class, 'installmentWechatPay'])
            ->name('api.installment.pay.wechat');




    });



});


