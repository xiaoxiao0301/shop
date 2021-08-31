<?php

namespace App\dict;

class Codes
{

    // 业务码返回定义
    const CODE_SUCCESS = 0; // 请求成功
    const CODE_INVALID_PARAM = 1000; // 参数异常
    const CODE_USER_EXISTS  = 1001; // 用户已存在
    const CODE_CAPTCHA_EXPIRE = 1002; // 验证码已过期
    const CODE_CAPTCHA_INVALID = 1003; // 验证码错误
    const CODE_NETWORK_BUSY = 1004; // 网络异常，请稍后再试
    const CODE_TOKEN_EXPIRE = 1005; // 未传递token或token过期
    const CODE_ACTION_NOT_ALLOWED = 1006; // 非法操作，修改不是自己的资源
    const CODE_DATA_NOT_FOUND = 1007; // 查找的资源没有
    const CODE_PRODUCT_INVALID = 1008; // 商品未上架
    const CODE_PRODUCT_ADD_FAVORITE = 1009; // 商品未上架
    const CODE_PRODUCT_NOT_FAVORITE = 1010; // 商品未收藏
    const CODE_COUPON_CODE_NOT_FOUND= 1011; // 优惠券不存在
    const CODE_COUPON_CODE_HAS_EXCHANGED = 1012; // 优惠券已被兑换完毕
    const CODE_COUPON_CODE_NOT_START = 1013; // 优惠券当前不能使用
    const CODE_COUPON_CODE_EXPIRED = 1014; // 优惠券已过期
    const CODE_ORDER_AMOUNT_NOT_REQUIRED = 1015; // 订单的总金额小于优惠券的最低金额
    const CODE_COUPON_USER_HAS_USED = 1016; // 不可重复使用同一张优惠券


    public static $message = [
        self::CODE_SUCCESS => "成功",
        self::CODE_INVALID_PARAM => "请求参数错误",
        self::CODE_USER_EXISTS => "用户已存在,请登录",
        self::CODE_CAPTCHA_EXPIRE => "验证码已过期",
        self::CODE_CAPTCHA_INVALID => "验证码错误",
        self::CODE_NETWORK_BUSY => "网络异常",
        self::CODE_TOKEN_EXPIRE => "请重新登陆",
        self::CODE_ACTION_NOT_ALLOWED => "无权限执行",
        self::CODE_DATA_NOT_FOUND => "数据不存在",
        self::CODE_PRODUCT_INVALID => "商品未上架",
        self::CODE_PRODUCT_ADD_FAVORITE => "商品已收藏",
        self::CODE_PRODUCT_NOT_FAVORITE => "商品未收藏",
        self::CODE_COUPON_CODE_NOT_FOUND => "优惠券不存在",
        self::CODE_COUPON_CODE_HAS_EXCHANGED => "优惠券已被兑换完毕",
        self::CODE_COUPON_CODE_NOT_START => "优惠券当前不能使用",
        self::CODE_COUPON_CODE_EXPIRED => "优惠券已过期",
        self::CODE_ORDER_AMOUNT_NOT_REQUIRED => "订单金额不满足该优惠券最低金额",
        self::CODE_COUPON_USER_HAS_USED => "改优惠券已经被使用过了",
    ];


    // http状态吗返回
    public const STATUS_CODE_OK = 200; // 成功的 GET、PUT、PATCH 或 DELETE 操作进行响应。也可以被用在不创建新资源的 POST 操作上
    public const STATUS_CODE_CREATED = 201; //  对创建新资源的 POST 操作进行响应。应该带着指向新资源地址的 Location 头
    public const STATUS_CODE_ACCEPT = 202; //  服务器接受了请求，但是还未处理，响应中应该包含相应的指示信息，告诉客户端该去哪里查询关于本次请求的信息
    public const STATUS_CODE_NOT_CONTENT = 204; //  对不会返回响应体的成功请求进行响应（比如 DELETE 请求）
    public const STATUS_CODE_BAD_REQUEST = 400; //  请求异常，比如请求中的body无法解析
    public const STATUS_CODE_NOT_AUTHORIZATION = 401; //  没有进行认证或者认证非法
    public const STATUS_CODE_FORBIDDEN = 403; //  服务器已经理解请求，但是拒绝执行它
    public const STATUS_CODE_NOT_FOUND = 404; //   请求一个不存在的资源
    public const STATUS_CODE_METHOD_NOT_ALLOWED = 405; //  所请求的 HTTP 方法不允许当前认证用户访问
    public const STATUS_CODE_GONE = 410; //  表示当前请求的资源不再可用。当调用老版本 API的时候很有用
    public const STATUS_CODE_UNSUPPORTED_MEDIA_TYPE = 415; //  如果请求中的内容类型是错误的
    public const STATUS_CODE_UNPROCESSABLE_ENTITY = 422; //  用来表示校验错误
    public const STATUS_CODE_TOO_MANY_REQUEST = 429; //  由于请求频次达到上限而被拒绝访问
    public const STATUS_CODE_ERROR_INTERNAL = 500;  // 服务器内部错误

    // 缓存相关
    public const CAPTCHA_CACHE_KEY_PREFIX = "Captcha-";
    public const PHONE_NUMBER_CACHE_KEY_PREFIX = "Phone_Number_";


    // 时间相关
    public const COMMON_CACHE_KEY_EXPIRE_SEC = 3 * 60;


    /**
     * 返回对于错误码信息
     *
     * @param string $code
     * @return string
     */
    public static function getMessageByCode(string $code): string
    {
        return self::$message[$code];
    }
}
