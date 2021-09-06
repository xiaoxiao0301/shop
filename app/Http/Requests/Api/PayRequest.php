<?php

namespace App\Http\Requests\Api;

class PayRequest extends BaseFormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'order_no' => 'required',
            'total_amount' => 'required',
            'method' => 'required'
        ];
    }

    public function attributes()
    {
        return [
            'order_no.required' => '订单编号',
            'total_amount.required' => '订单金额',
            'method' => '支付方式',
        ];
    }
}
