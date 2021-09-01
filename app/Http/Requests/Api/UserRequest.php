<?php

namespace App\Http\Requests\Api;


class UserRequest extends BaseFormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'code_key' => 'required',
            'code' => 'required',
        ];
    }

    public function attributes()
    {
        return [
            'code_key' => '验证码key',
            'code' => '验证码',
        ];
    }
}
