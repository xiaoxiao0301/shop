<?php

use Illuminate\Routing\Router;
use Illuminate\Support\Facades\Route;
use Dcat\Admin\Admin;

Admin::routes();

Route::group([
    'prefix'     => config('admin.route.prefix'),
    'namespace'  => config('admin.route.namespace'),
    'middleware' => config('admin.route.middleware'),
], function (Router $router) {

    $router->get('/', 'HomeController@index');

    $router->resource('users', 'UserController');
    $router->resource('products', 'ProductController');
    $router->resource('coupons', 'CouponController');
    $router->resource('orders', 'OrderController');
    $router->post('orders/{order}/ship', 'OrderController@ship')->name('order.ship');
    $router->get('refund', 'ApplyRefundController@applyRefundLists')->name('apply.refund');
    $router->post('refund', 'ApplyRefundController@handleRefund')->name('refund.handler');
    $router->resource('categories', 'CategoryController');
    $router->get('api/categories', 'CategoryController@ApiCategories');
    $router->resource('crowdfunding_products', 'CrowdfundingProductController');
    $router->resource('seckill_products', 'SeckillProductController');
});
