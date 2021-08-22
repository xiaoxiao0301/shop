<?php

namespace App\Http\Requests\Api;

class AuthorizationRequest extends BaseRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'code' => 'required',
            'code_key' => 'required',
        ];
    }

    public function messages()
    {
        return [
            'code.required' =>  '验证码不能为空',
            'code_key.required' => '验证码key不能为空'
        ];
    }
}
