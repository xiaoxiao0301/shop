<?php

namespace App\Http\Requests\Api;

class ApplyRefundRequest extends BaseFormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'reason' => 'required'
        ];
    }

    public function attributes()
    {
        return [
            'reason' => '退款原因',
        ];
    }
}
