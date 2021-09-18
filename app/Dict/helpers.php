<?php

function frp_url($routeName, $parameters = [])
{
    if (app()->environment('local') && $url = config('app.frp_url')) {
        // route() 函数第三个参数代表是否绝对路径
        return $url . route($routeName, $parameters, false);
    }
    return route($routeName, $parameters);
}
