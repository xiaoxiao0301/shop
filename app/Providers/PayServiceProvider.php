<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Yansongda\Pay\Pay;

class PayServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->singleton('alipay', function () {
            $config = config('pay');
            $config['alipay']['default']['notify_url'] = frp_url('api.alipay.notify');
            $config['alipay']['default']['return_url'] = frp_url('api.alipay.return');
            return Pay::alipay($config);
        });

        $this->app->singleton('wechat', function () {
            $config = config('pay');
            return Pay::wechat($config);
        });
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
