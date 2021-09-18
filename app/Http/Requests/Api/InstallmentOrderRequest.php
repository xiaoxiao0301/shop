<?php

namespace App\Http\Requests\Api;

use Illuminate\Validation\Rule;

class InstallmentOrderRequest extends BaseFormRequest
{

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'count' => [
                'required',
                Rule::in(array_keys(config('installment.installment_fee_rate'))),
            ]
        ];
    }

    public function attributes()
    {
        return [
            'count' => '分期数'
        ];
    }
}
