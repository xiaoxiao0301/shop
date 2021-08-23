<?php

namespace App\Providers;

use Godruoyi\Snowflake\LaravelSequenceResolver;
use Godruoyi\Snowflake\Snowflake;
use Illuminate\Support\ServiceProvider;

class SnowFlakeServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        // php生成雪花id  https://github.com/godruoyi/php-snowflake
        $this->app->singleton(Snowflake::class, function ($app) {
            return (new Snowflake())->setStartTimeStamp(strtotime("20201-08-23") * 1000)
                ->setSequenceResolver(new LaravelSequenceResolver($this->app->get('cache')->store()));
        });
        $this->app->alias(Snowflake::class, "snowflake");
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
