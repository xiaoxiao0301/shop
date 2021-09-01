<?php

namespace App\Services\impl;

use App\Dict\RedisCacheKeys;
use App\Dict\ResponseJsonData;
use App\Services\SmsServicesIf;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Str;
use Log;
use Overtrue\EasySms\Exceptions\NoGatewayAvailableException;

class SmsServicesImpl implements SmsServicesIf
{

    /**
     * 发送验证码
     *
     * @param $phone
     * @throws Exception
     * @return JsonResponse
     */
    public function sendCode($phone): JsonResponse
    {
        if (!app()->environment("production")) {
            $code = 6379;
        } else {
            $code = str_pad(random_int(1, 9999), 4, 0, STR_PAD_LEFT);
            try {
                app('sms')->send($phone, [
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
                ResponseJsonData::responseInternal();
            }
        }
        $cacheKey = RedisCacheKeys::USER_PHONE_CODE_CACHE_KEY . Str::random(15);
        $cacheKeyExpires = Carbon::now()->addSeconds(RedisCacheKeys::USER_PHONE_EXPIRE_SEC);
        Cache::put($cacheKey, [
            'phone' => $phone,
            'code' => $code,
        ], $cacheKeyExpires);
        $result = [
            'codeKey' => $cacheKey,
            'codeKeyExpire' => $cacheKeyExpires->toDateTimeString()
        ];
        return ResponseJsonData::responseOk($result);
    }
}
