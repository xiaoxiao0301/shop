<?php

namespace App\Services;

use App\Models\UserAddress;

interface UserServicesIf
{
    public function checkUserIsExistsByPhone(string $phone): bool;
    public function saveUsers(array $userData);
    public function getUserInfoByUserPhone(string $phone);
    public function getCurrentUserInfo();
    public function checkUserCollectProduct($product);
    public function getUserAddressesList();
    public function getUserCollectProductLists();

    public function getUserAddressListsByUserId($userId);
    public function getUserAddressListsByUserIdAndPageSize($userId, $size);
    public function getUserAddressListsByUserIdAndPageAndSize($userId, $offset, $limit);
    public function saveUserAddress(UserAddress $address);
    public function updateUserAddress($userAddress, $data);
    public function deleteUserAddress($userAddress);
    public function getCurrentUsedAddressList();
}
