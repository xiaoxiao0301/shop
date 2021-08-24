<?php

namespace App\Services;

interface UserAddressServicesIf
{
    public function getUserAddressListsByUserId($userId);
    public function getUserAddressListsByUserIdAndPageSize($userId, $size);
    public function getUserAddressListsByUserIdAndPageAndSize($userId, $offset, $limit);
    public function saveUserAddress($addressData);
    public function updateUserAddress($userAddress, $data);
    public function deleteUserAddress($userAddress);
}
