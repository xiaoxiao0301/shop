<?php

namespace App\Dict;

/**
 * Redis缓存相关
 */
class RedisCacheKeys
{
    // |--------------------------------------- Key
    // 手机号码
    const USER_PHONE_CODE_CACHE_KEY = 'user_phone_number_key_';

    // 已创建订单，但未支付
    const ORDER_NOT_PAY_LIST_KEY = 'order_not_pay';


    // |--------------------------------------- 缓存时间
    // 手机验证码过期时间
    const USER_PHONE_EXPIRE_SEC = 5 * 60;
    // 订单支付超时时间
    const ORDER_PAY_LIMIT_SEC = 30 * 60;
}
