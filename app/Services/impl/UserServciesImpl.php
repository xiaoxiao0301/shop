<?php

namespace App\Services\impl;

use App\Models\User;

class UserServciesImpl implements \App\Services\UserServicesInterface
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
     * @return User
     */
    public function saveUsers(User $user): User
    {
        return User::insert($user);
    }
}
