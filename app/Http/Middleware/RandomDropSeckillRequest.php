<?php

namespace App\Http\Middleware;

use App\Dict\HttpCodes;
use App\Exceptions\InvalidRequestException;
use Closure;
use Illuminate\Http\Request;

/**
 * 电商的秒杀系统都会需要用户提前预约，只有预约了的用户才有资格去参与秒杀
 * 假设 iPhone X 在天猫首发时有 10000 部库存，而预约购买的人数是 100 万，
 * 也就是预约和库存比是 100:1，一百个用户里只有一个能抢到。
 * 既然大部分人都不可能抢到，那我们完全可以在用户提交下单请求时生成一个 0 ~ 100 的随机数，
 * 如果这个数大等于 2 则直接告诉用户抢购的人太多请重试，这样能落到 Redis 的请求就只剩下了 2% 也就是 2 万人。
 */
class RandomDropSeckillRequest
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  $percent  // $percent 参数是在路由添加中间件时传入
     * @return mixed
     */
    public function handle(Request $request, Closure $next, $percent)
    {
        if (random_int(0, 100) < (int)$percent) {
            throw new InvalidRequestException('参与用户过多，请稍后再试', HttpCodes::STATUS_FORBIDDEN);
        }
        return $next($request);
    }
}
