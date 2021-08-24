<?php

namespace App\Http\Requests\Api;

class UserAddressRequest extends BaseRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        switch ($this->method()) {
            case "GET":
                return [
                    "page" => "required|integer",
                    "size" => "required|integer"
                ];
            case "POST":
            case "PUT":
                return [
                    'province'      => 'required',
                    'city'          => 'required',
                    'district'      => 'required',
                    'address'       => 'required',
                    'zip'           => 'required',
                    'contact_name'  => 'required',
                    'contact_phone' => 'required',
                ];
        }
        return [];
    }

    /**
     * @return string[]
     */
    public function messages(): array
    {
        return [
            "page.required" => "页码不能为空",
            "page.integer" => "页码只能是数字",
            "size.required" => "每页大小不能为空",
            "size.integer" => "每页大小只能是数字",
        ];
    }

    /**
     * @return string[]
     */
    public function attributes(): array
    {
        return [
            'province'      => '省',
            'city'          => '城市',
            'district'      => '地区',
            'address'       => '详细地址',
            'zip'           => '邮编',
            'contact_name'  => '姓名',
            'contact_phone' => '电话号码',
        ];
    }
}
