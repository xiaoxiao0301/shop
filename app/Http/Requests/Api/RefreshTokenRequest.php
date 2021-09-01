<?php

namespace App\Http\Requests\Api;

class RefreshTokenRequest extends BaseFormRequest
{

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'token' => 'required'
        ];
    }

    public function attributes()
    {
        return [
            'token' => '令牌'
        ];
    }
}
