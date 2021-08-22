<?php

namespace App\Http\Controllers\Api;

use App\dict\Codes;
use App\Http\Requests\Api\CaptchaRequest;
use App\Services\impl\UserServciesImpl;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Mews\Captcha\Captcha;

class CaptchasController extends BaseController
{
    /**
     * 获取验证码信息
     *
     * @param CaptchaRequest $captchaRequest
     * @param Captcha $captcha
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function info(CaptchaRequest $captchaRequest, Captcha $captcha)
    {
        $phone = $captchaRequest->phone;
        $existsUser = $this->userSerivce->checkUserIsExistsByPhone($phone);
        if ($existsUser) {
            return $this->responseData(Codes::CODE_USER_EXISTS, Codes::getMessageByCode(Codes::CODE_USER_EXISTS),
                [], Codes::STATUS_CODE_FORBIDDEN
            );
        }
        /**
         captchaInfo :
             array {
                'sensitive' => false,
                'key' => '', 绑定的数值
                'img' => "dats:image/png;....."  base64 编码过后的
             }
         */
        $captchaInfo = $captcha->create('flat', true);
        $captchaKey = Codes::CAPTCHA_CACHE_KEY_PREFIX . Str::random(15); // 缓存验证码key
        $captchaExpiredAt = Carbon::now()->addSeconds(Codes::COMMON_CACHE_KEY_EXPIRE_SEC); // 缓存的验证码3分钟有效

        Cache::put($captchaKey, ['phone' => $phone, 'captcha_key' => $captchaInfo['key']], $captchaExpiredAt);

        $result = [
            "captcha_key" => $captchaKey,
            "captcha_expired_at" => $captchaExpiredAt->toDateTimeString(),
            "captcha_image" => $captchaInfo["img"],
        ];

        return $this->responseData(Codes::CODE_SUCCESS, Codes::getMessageByCode(Codes::CODE_SUCCESS),
            $result, Codes::STATUS_CODE_CREATED,
        );
    }


    /**
     * 将base64编码图片存储到系统并返回地址
     *
     * @param string $dataImg
     * @return string
     */
    private function ConvertImgBase64ToAccessUrl(string $dataImg): string
    {
        $dataImg = "data:image/png;base64,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";
        preg_match('/^(data:\s*image\/(\w+);base64,)/', $dataImg, $res);
        $coverImg = base64_decode(str_replace($res[1], '', $dataImg));
        Storage::put('captcha.png', $coverImg);
//        Storage::delete('captcha.png');  删除文件
        return Storage::url('captcha.png');
    }
}
