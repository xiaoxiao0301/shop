<?php

namespace App\Dict;

/**
 * 定义 前端的业务码
 */
class FrontCodes
{
    const CODE_SUCCESS = 0; // 正常响应
    const CODE_INTERNAL = 1001;  // 服务器异常
    const CODE_INVALID_REQUEST = 1000;  // 请求异常或者校验异常
}
