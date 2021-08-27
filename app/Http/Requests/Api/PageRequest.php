<?php

namespace App\Http\Requests\Api;


class PageRequest extends BaseRequest
{


    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            "page" => "required|integer",
            "size" => "required|integer",
            "search" => "nullable",
            "order" => "nullable",
        ];
    }

    public function attributes()
    {
        return [
            'page' => '分页页码',
            'size' => '每页大小',
        ];
    }
}
