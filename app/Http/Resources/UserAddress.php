<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class UserAddress extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return [
//            'user_id' => $this->user_id,
//            'province' => $this->province,
//            'city' => $this->city,
//            'district' => $this->district,
//            'address' => $this->address,
            'contact_name' => $this->contact_name,
            'address' => $this->full_address,
            'zip' => $this->zip,
            'contact_phone' => $this->contact_phone,
        ];

    }
}
