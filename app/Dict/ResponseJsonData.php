<?php

namespace App\Dict;

use Illuminate\Http\JsonResponse;

/**
 * 返回数据格式
 */
class ResponseJsonData
{
    /**
     * 返回 200 响应
     * @param array $data
     * @return JsonResponse
     */
    public static function responseOk(array $data = []):JsonResponse
    {
        return self::returnData(
            FrontCodes::CODE_SUCCESS,
            "操作成功",
            $data,
            HttpCodes::STATUS_OK
        );
    }

    /**
     * 返回400响应
     *
     * @param string $message
     * @return JsonResponse
     */
    public static function responseBadRequest(string $message):JsonResponse
    {
        return self::returnData(
            FrontCodes::CODE_INVALID_REQUEST,
            $message,
            [],
            HttpCodes::STATUS_BAD_REQUEST
        );
    }

    /**
     * 返回401响应
     *
     * @param string $message
     * @return JsonResponse
     */
    public static function responseUnAuthorization(string $message):JsonResponse
    {
        return self::returnData(
            FrontCodes::CODE_INVALID_REQUEST,
            $message,
            [],
            HttpCodes::STATUS_NOT_AUTHORIZATION
        );
    }

    /**
     * 返回403响应
     *
     * @param string $message
     * @return JsonResponse
     */
    public static function responseForbidden(string $message):JsonResponse
    {
        return self::returnData(
            FrontCodes::CODE_INVALID_REQUEST,
            $message,
            [],
            HttpCodes::STATUS_FORBIDDEN
        );
    }

    /**
     * 返回404响应
     *
     * @param string $message
     * @return JsonResponse
     */
    public static function responseNotFound(string $message):JsonResponse
    {
        return self::returnData(
            FrontCodes::CODE_INVALID_REQUEST,
            $message,
            [],
            HttpCodes::STATUS_NOT_FOUND
        );
    }

    /**
     * 返回422响应
     *
     * @param string $message
     * @param int $code
     * @return JsonResponse
     */
    public static function responseUnProcessAble(string $message, int $code = HttpCodes::STATUS_UNPROCESSABLE_ENTITY):JsonResponse
    {
        return self::returnData(
            FrontCodes::CODE_INVALID_REQUEST,
            $message,
            [],
            $code
        );
    }

    /**
     * 返回429响应
     *
     * @param string $message
     * @return JsonResponse
     */
    public static function responseLimited(string $message):JsonResponse
    {
        return self::returnData(
            FrontCodes::CODE_INVALID_REQUEST,
            $message,
            [],
            HttpCodes::STATUS_TOO_MANY_REQUEST
        );
    }


    /**
     * 返回500响应
     *
     * @return JsonResponse
     */
    public static function responseInternal():JsonResponse
    {
        return self::returnData(
            FrontCodes::CODE_INTERNAL,
            ResponseMessages::MESSAGE_INTERNAL_ERROR,
            [],
            HttpCodes::STATUS_ERROR_INTERNAL
        );
    }

    /**
     * 定义接口返回格式
     *
     * @param int $code
     * @param string $message
     * @param array $data
     * @param int $httpCode
     * @return JsonResponse
     */
    public static function returnData(int $code, string $message, array $data, int $httpCode):JsonResponse
    {
        return response()->json([
            'code' => $code,
            'message' => $message,
            'data' => $data,
        ])->setStatusCode($httpCode);
    }
}
