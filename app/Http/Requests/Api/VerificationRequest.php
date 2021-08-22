<?php

namespace App\Http\Requests\Api;

use Illuminate\Foundation\Http\FormRequest;

class VerificationRequest extends BaseRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            "captcha_code" => "required|string",
            "captcha_key" => "required|string"
        ];
    }

    public function messages()
    {
        return [
            "captcha_code.required" => "图片验证码不能为空",
            "captcha_key.required" => "图片验证码 key不能为空"
        ];
    }
}
