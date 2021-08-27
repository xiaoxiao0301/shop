<?php

namespace App\Services\impl;

use App\Models\User;
use App\Services\UserServicesIf;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Builder;
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
}
