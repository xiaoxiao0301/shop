<?php

namespace App\Http\Requests\Api;

use App\Dict\FrontCodes;
use App\Dict\HttpCodes;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class BaseFormRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * 重新定义ajax请求是表单验证失败返回格式
     *
     * @param Validator $validator
     */
    public function failedValidation(Validator $validator)
    {
        throw new HttpResponseException(response()->json([
            'code' => FrontCodes::CODE_INVALID_REQUEST,
            'message' => $validator->errors()->first(),
        ])->setStatusCode(HttpCodes::STATUS_UNPROCESSABLE_ENTITY));
    }
}
