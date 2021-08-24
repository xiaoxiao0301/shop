<?php

namespace App\Services\impl;

use App\Models\UserAddress;
use App\Services\UserAddressServicesIf;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;

class UserAddressServiceImpl implements UserAddressServicesIf
{

    /**
     * 获取特定用户的收货地址
     *
     * @param $userId
     * @return Collection
     */
    public function getUserAddressListsByUserId($userId): Collection
    {
       return UserAddress::query()->where("user_id", $userId)
           ->orderBy('id', 'desc')
           ->get();
    }

    /**
     * @param $userId
     * @param $size
     * @return LengthAwarePaginator
     */
    public function getUserAddressListsByUserIdAndPageSize($userId, $size): LengthAwarePaginator
    {
        return UserAddress::query()->where("user_id", $userId)
            ->orderBy('id', 'desc')
            ->paginate($size);
    }

    /**
     * 查询用户的收货列表，利用 mysql limit分页
     *
     * @param $userId
     * @param $offset
     * @param $limit
     * @return Collection
     */
    public function getUserAddressListsByUserIdAndPageAndSize($userId, $offset, $limit): Collection
    {
        return UserAddress::query()->where("user_id", $userId)
            ->orderBy('id', 'desc')
            ->offset($offset)
            ->limit($limit)
            ->get();
    }

    /**
     * 保存用户收货地址
     *
     * @param $addressData
     * @return UserAddress
     */
    public function saveUserAddress($addressData): UserAddress
    {
        return UserAddress::create($addressData);
    }

    /**
     * 更新用户收货地址
     *
     * @param $userAddress
     * @param $data
     * @return bool
     */
    public function updateUserAddress($userAddress, $data): bool
    {
        return $userAddress->update($data);
    }


    /**
     * 删除用户的收货地址
     *
     * @param $userAddress
     * @return bool
     */
    public function deleteUserAddress($userAddress): bool
    {
        return $userAddress->delete();
    }
}
