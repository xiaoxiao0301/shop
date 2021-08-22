<?php

namespace App\Http\Requests\Api;

use App\dict\Codes;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class BaseRequest extends FormRequest
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

    protected function failedValidation(Validator $validator)
    {
        throw new HttpResponseException(response()->json([
            'code' => Codes::CODE_INVALID_PARAM,
            'message' => $validator->errors()->first(),
            'data' => [],
        ])->setStatusCode(Codes::STATUS_CODE_UNPROCESSABLE_ENTITY));
    }
}
