<?php

namespace App\Dict;

/**
 * 定义http 状态码
 */
class HttpCodes
{
    const STATUS_OK = 200; // 成功的 GET、PUT、PATCH 或 DELETE 操作进行响应。也可以被用在不创建新资源的 POST 操作上
    const STATUS_CREATED = 201; //  对创建新资源的 POST 操作进行响应。应该带着指向新资源地址的 Location 头
    const STATUS_ACCEPT = 202; //  服务器接受了请求，但是还未处理，响应中应该包含相应的指示信息，告诉客户端该去哪里查询关于本次请求的信息
    const STATUS_NOT_CONTENT = 204; //  对不会返回响应体的成功请求进行响应（比如 DELETE 请求）
    const STATUS_BAD_REQUEST = 400; //  请求异常，比如请求中的body无法解析
    const STATUS_NOT_AUTHORIZATION = 401; //  没有进行认证或者认证非法
    const STATUS_FORBIDDEN = 403; //  服务器已经理解请求，但是拒绝执行它
    const STATUS_NOT_FOUND = 404; //   请求一个不存在的资源
    const STATUS_METHOD_NOT_ALLOWED = 405; //  所请求的 HTTP 方法不允许当前认证用户访问
    const STATUS_GONE = 410; //  表示当前请求的资源不再可用。当调用老版本 API的时候很有用
    const STATUS_UNSUPPORTED_MEDIA_TYPE = 415; //  如果请求中的内容类型是错误的
    const STATUS_UNPROCESSABLE_ENTITY = 422; //  用来表示校验错误
    const STATUS_TOO_MANY_REQUEST = 429; //  由于请求频次达到上限而被拒绝访问
    const STATUS_ERROR_INTERNAL = 500;  // 服务器内部错误
}
