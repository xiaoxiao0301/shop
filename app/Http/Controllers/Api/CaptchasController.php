<?php

namespace App\Http\Controllers\Api;

use App\dict\Codes;
use App\Http\Requests\Api\CaptchaRequest;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\JsonResponse;
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
     * @return JsonResponse
     * @throws Exception
     */
    public function info(CaptchaRequest $captchaRequest, Captcha $captcha): JsonResponse
    {
        $phone = $captchaRequest->get('phone');
        $existsUser = $this->userService->checkUserIsExistsByPhone($phone);
        if ($existsUser) {
            return $this->responseData(Codes::CODE_USER_EXISTS, [], Codes::STATUS_CODE_FORBIDDEN);
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

        return $this->responseData(Codes::CODE_SUCCESS, $result, Codes::STATUS_CODE_CREATED);
    }


    /**
     * 将base64编码图片存储到系统并返回地址
     *
     * @param string $dataImg
     * @return string
     */
    private function ConvertImgBase64ToAccessUrl(string $dataImg): string
    {
        preg_match('/^(data:\s*image\/(\w+);base64,)/', $dataImg, $res);
        $coverImg = base64_decode(str_replace($res[1], '', $dataImg));
        Storage::put('captcha.png', $coverImg);
//        Storage::delete('captcha.png');  删除文件
        return Storage::url('captcha.png');
    }
}
