<?php

namespace App\Services\impl;

use App\Models\User;
use App\Models\UserAddress;
use App\Services\UserServicesIf;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

class UserServiceImpl implements UserServicesIf
{

    /**
     * 根据手机号判断用户是否存在
     *
     * @param string $phone
     * @return bool
     */
    public function checkUserIsExistsByPhone(string $phone): bool
    {
        $user = User::query()->where("phone", $phone)->first();
        if ($user) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 注册用户
     *
     * @param array $userData
     * @return User|Model
     */
    public function saveUsers(array $userData)
    {
        return User::create($userData);
    }


    /**
     * 根据手机号查询用户信息
     *
     * @param string $phone
     * @return Builder|Model|object|null
     */
    public function getUserInfoByUserPhone(string $phone)
    {
        return User::query()->where("phone", $phone)->first();
    }

    /**
     * @return Authenticatable|null
     */
    public function getCurrentUserInfo(): Authenticatable
    {
        return auth()->user();
    }

    /**
     * 判断用户是否收藏了商品
     *
     * @param $product
     * @return bool
     */
    public function checkUserCollectProduct($product): bool
    {
        /** @var User $user */
        $user = $this->getCurrentUserInfo();
        if ($user) {
            return boolval($user->favoriteProducts()->find($product->id));
        } else {
            return false;
        }
    }

    /**
     * 用户收藏商品列表
     *
     * @return array
     */
    public function getUserCollectProductLists(): array
    {
        /** @var User $user */
        $user = $this->getCurrentUserInfo();
        return $user->favoriteProducts->toArray();
    }

    /**
     * 用户收货地址列表
     *
     * @return array
     */
    public function getUserAddressesList(): array
    {
        /** @var User $user */
        $user = $this->getCurrentUserInfo();
        return $user->addresses->toArray();
    }

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
     * @param UserAddress $address
     * @return bool
     */
    public function saveUserAddress(UserAddress $address): bool
    {
        $user = $this->getCurrentUserInfo();
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


    /**
     * 根据使用时间降序获取收货地址列表
     *
     * @return array
     */
    public function getCurrentUsedAddressList(): array
    {
        /** @var User $user */
        $user = $this->getCurrentUserInfo();
        return $user->addresses()->orderBy('last_used_at', 'desc')->get()->toArray();
    }

}
