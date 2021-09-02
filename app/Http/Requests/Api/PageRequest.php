<?php

namespace App\Http\Requests\Api;


class PageRequest extends BaseFormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        return [
            'page' => 'required|min:1',
            'size' => 'required',
        ];
    }

    /**
     * @return string[]
     */
    public function attributes(): array
    {
        return [
            'page' => '分页页码',
            'size' => '每页大小',
        ];
    }
}
