<?php

namespace App\Http\Requests\Api;


class CaptchaRequest extends BaseRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'phone' => [
                'required',
                'regex:/^((13[0-9])|(14[5,7,9])|(15[^4])|(18[0-9])|(17[0,1,3,5,6,7,8]))\\d{8}$/',
//                'unique:users'
            ]
        ];
    }

    public function messages()
    {
       return [
           'phone.required' => '手机号不能为空',
           'phone.regex' => '手机号非法',
       ];
    }
}
