<?php

namespace App\Services;

use App\Models\UserAddress;
use Illuminate\Contracts\Auth\Authenticatable;

interface UserAddressServicesIf
{
    public function getUserAddressListsByUserId($userId);
    public function getUserAddressListsByUserIdAndPageSize($userId, $size);
    public function getUserAddressListsByUserIdAndPageAndSize($userId, $offset, $limit);
    public function saveUserAddress(Authenticatable $user, UserAddress $address);
    public function updateUserAddress($userAddress, $data);
    public function deleteUserAddress($userAddress);
}
