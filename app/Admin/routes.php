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
    $router->resource('skus', 'ProductSkuController');

    $router->resource('orders', 'OrderController');
    $router->post('orders/{order}/ship', 'OrderController@ship')
        ->name('order.ship');

});
