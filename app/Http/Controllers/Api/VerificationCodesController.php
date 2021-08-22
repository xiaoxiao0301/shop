<?php

namespace App\Http\Controllers\Api;

use App\dict\Codes;
use App\Http\Requests\Api\VerificationRequest;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Overtrue\EasySms\EasySms;
use Overtrue\EasySms\Exceptions\NoGatewayAvailableException;

class VerificationCodesController extends BaseController
{
    /**
     * 发送短信验证码
     *
     * @param VerificationRequest $request
     * @param EasySms $sms
     * @return \Illuminate\Http\JsonResponse
     * @throws \Overtrue\EasySms\Exceptions\InvalidArgumentException
     */
    public function check(VerificationRequest $request, EasySms $sms)
    {
        $cacheCapthchaInfo = Cache::get($request->captcha_key);
        // 缓存信息校验
        if (!$cacheCapthchaInfo) {
            return $this->responseData(Codes::CODE_CAPTCHA_EXPIRE,
                Codes::getMessageByCode(Codes::CODE_CAPTCHA_EXPIRE),
                [],
                Codes::STATUS_CODE_UNPROCESSABLE_ENTITY);
        }
        // 判断验证码
        if (!captcha_api_check($request->captcha_code, $cacheCapthchaInfo["captcha_key"], "flat")) {
            Cache::forget($request->captcha_key);
            return $this->responseData(Codes::CODE_CAPTCHA_INVALID,
                Codes::getMessageByCode(Codes::CODE_CAPTCHA_INVALID),
                [],
                Codes::STATUS_CODE_NOT_AUTHORIZATION
            );
        }

        Cache::forget($request->captcha_key); // 删除缓存的验证码key

        // 短信验证码, 本地不进行正常的发送
        $phone = $cacheCapthchaInfo["phone"];
        if (!app()->environment("production")) {
            $code = 6379;
        } else {
            $code = str_pad(random_int(1, 9999), 4, 0, STR_PAD_LEFT);
            try {
                $result = $sms->send($phone, [
                    'template' => 'SMS_179611210',
                    'data' => [
                        'code' => $code
                    ]
                ]);
            } catch (NoGatewayAvailableException $exception) {
                $message = $exception->getException('aliyun')->getMessage();
                Log::error("send sms error", [
                    "phone" => $phone,
                    "message" => $message
                ]);
                return $this->responseData(Codes::CODE_NETWORK_BUSY,
                    Codes::getMessageByCode(Codes::CODE_NETWORK_BUSY),
                    [],
                    Codes::STATUS_CODE_ERROR_INTERNAL
                );
            }
        }

        $codeKey = Codes::PHONE_NUMBER_CACHE_KEY_PREFIX . Str::random(15);
        $codeKeyExpiredAt = Carbon::now()->addSeconds(Codes::COMMON_CACHE_KEY_EXPIRE_SEC); // 短信验证码3分钟内有效
        Cache::put($codeKey, ["phone" => $phone, "code" => $code], $codeKeyExpiredAt);

        $result = [
            "codeKey" => $codeKey,
            "codeKeyExpire" => $codeKeyExpiredAt->toDateTimeString()
        ];

        return $this->responseData(Codes::CODE_SUCCESS,
            Codes::getMessageByCode(Codes::CODE_SUCCESS),
            $result,
            Codes::STATUS_CODE_OK
        );

    }
}
