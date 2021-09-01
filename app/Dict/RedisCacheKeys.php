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


    // |--------------------------------------- 缓存时间
    // 手机验证码过期时间
    const USER_PHONE_EXPIRE_SEC = 5 * 60;
}
