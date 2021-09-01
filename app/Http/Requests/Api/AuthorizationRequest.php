<?php

namespace App\Http\Requests\Api;

class AuthorizationRequest extends BaseFormRequest
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
//                'unique:users'  单纯注册接口可以添加这个条件
            ]
        ];
    }

    public function attributes()
    {
        return [
            'phone' => '手机号码',
        ];
    }
}
