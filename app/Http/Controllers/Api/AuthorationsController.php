<?php

namespace App\Http\Controllers\Api;

use App\dict\Codes;
use App\Http\Requests\Api\AuthorizationRequest;
use App\Http\Requests\Api\CaptchaRequest;
use Carbon\Carbon;
use Godruoyi\Snowflake\Snowflake;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Overtrue\EasySms\EasySms;
use Overtrue\EasySms\Exceptions\NoGatewayAvailableException;

class AuthorationsController extends BaseController
{
   public function store(AuthorizationRequest $request, Snowflake $snowflake)
    {
        $codeCacheInfo = Cache::get($request->code_key);
        if (!$codeCacheInfo) {
            return $this->responseData(Codes::CODE_CAPTCHA_EXPIRE,
                Codes::getMessageByCode(Codes::CODE_CAPTCHA_EXPIRE),
                [],
                Codes::STATUS_CODE_UNPROCESSABLE_ENTITY
            );
        }
        // 短信验证码验证
        $phone = $codeCacheInfo["phone"];
        if (!($codeCacheInfo['code'] ==  $request->code)) {
            return $this->responseData(Codes::CODE_CAPTCHA_INVALID,
                Codes::getMessageByCode(Codes::CODE_CAPTCHA_INVALID),
                [],
                Codes::STATUS_CODE_UNPROCESSABLE_ENTITY
            );
        }
        // 清楚短信验证码key
        Cache::forget($request->code_key);

        // 有用户直接登陆，没有就创建用户再登陆
        $user = $this->userSerivce->getUserInfoByUserPhone($phone);
        if (!$user) {
            // 创建用户
            $userData = [
                "user_id" => $snowflake->id(),
                "name" => "boy_" . Str::random(5),
                "phone" => $phone,
                "password" => "$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi",
            ];
            $user = $this->userSerivce->saveUsers($userData);
        }
        $token = auth()->fromUser($user);
        return $this->responseData(Codes::CODE_SUCCESS,
            Codes::getMessageByCode(Codes::CODE_SUCCESS),
            $this->generateRespondDataWithToken($token),
            Codes::STATUS_CODE_OK
        );

    }


    /**
     * 发送短信验证码
     *
     * @param CaptchaRequest $request
     * @param EasySms $sms
     * @return \Illuminate\Http\JsonResponse
     * @throws \Overtrue\EasySms\Exceptions\InvalidArgumentException
     */
    public function authCode(CaptchaRequest $request, EasySms $sms)
    {
        // 短信验证码, 本地不进行正常的发送
        $phone = $request->phone;
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


    /**
     * 返回jwt信息
     *
     * @param $token
     * @return array
     */
    protected function generateRespondDataWithToken($token)
    {
        return [
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60 // 3600秒, 单位是分钟 jwt配置文件中ttl配置项
        ];
    }
}
