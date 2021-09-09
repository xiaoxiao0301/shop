<?php

namespace App\Http\Requests\Api;


use Illuminate\Validation\Rule;

class SendReviewRequest extends BaseFormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'reviews' => 'required|array',
            'reviews.*.id' => [
                'required', //order_items主键ID
                Rule::exists('order_items', 'id')
                    ->where('order_id', $this->route('order')->order_no)
            ],
            'reviews.*.rating' => 'required|integer|between:1,5',
            'reviews.*.review' => 'required'
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
