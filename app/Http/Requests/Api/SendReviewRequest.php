<?php

namespace App\Http\Requests\Api;


use Illuminate\Validation\Rule;

class SendReviewRequest extends BaseRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'reviews'          => ['required', 'array'],
            'reviews.*.id'     => [
                'required',
                // 从表 order_items 取出 order_id 判断 order_id 和 传递order的order_no是否匹配
                Rule::exists('order_items', 'order_id')->where('order_id', $this->route('order')->order_no)
            ],
            'reviews.*.rating' => ['required', 'integer', 'between:1,5'],
            'reviews.*.review' => ['required'],
        ];
    }

    public function attributes()
    {
        return [
            'reviews.*.rating' => '评分',
            'reviews.*.review' => '评价',
        ];
    }
}
