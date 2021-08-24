<?php

namespace App\Services\impl;

use App\Models\User;
use App\Services\UserServicesIf;

class UserServciesImpl implements UserServicesIf
{

    /**
     * 根据手机号判断用户是否存在
     *
     * @param string $phone
     * @return bool
     */
    public function checkUserIsExistsByPhone(string $phone): bool
    {
        $user = User::where("phone", $phone)->first();
        if ($user) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 注册用户
     *
     * @param User $user
     * @return User|\Illuminate\Database\Eloquent\Model
     */
    public function saveUsers(array $userData)
    {
        return User::create($userData);
    }


    /**
     * 根据手机号查询用户信息
     *
     * @param string $phone
     * @return User|\Illuminate\Database\Eloquent\Builder|\Illuminate\Database\Eloquent\Model|object
     */
    public function getUserInfoByUserPhone(string $phone)
    {
        return User::query()->where("phone", $phone)->first();
    }

    public function getCurrentUserInfo()
    {
        return auth()->user();
    }
}
