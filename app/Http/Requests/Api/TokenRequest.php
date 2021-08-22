<?php

namespace App\Http\Requests\Api;

class TokenRequest extends BaseRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            "token" => "required"
        ];
    }

    public function messages()
    {
        return [
            "token.required" => "token不能为空"
        ];
    }
}
