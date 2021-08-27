<?php

namespace App\Services\impl;

use App\Models\UserAddress;
use App\Services\UserAddressServicesIf;
use Illuminate\Contracts\Auth\Authenticatable;
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
     * 通过关联关系保存地址信息， associate只有belongsTo这个关联这边有
     *
     * @param Authenticatable $user
     * @param UserAddress $address
     * @return bool
     */
    public function saveUserAddress(Authenticatable $user, UserAddress $address): bool
    {
        $address->user()->associate($user);
        return $address->save();
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
