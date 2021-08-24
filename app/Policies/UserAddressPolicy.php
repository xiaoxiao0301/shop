<?php

namespace App\Policies;

use App\Models\User;
use App\Models\UserAddress;
use Illuminate\Auth\Access\HandlesAuthorization;

class UserAddressPolicy
{
    use HandlesAuthorization;

    /**
     * Create a new policy instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * 修改收货地址权限
     *
     * @param User $user
     * @param UserAddress $address
     * @return bool
     */
    public function update(User $user, UserAddress $address): bool
    {
        return $user->isAuthOf($address);
    }

    /**
     * 删除收货地址权限
     *
     * @param User $user
     * @param UserAddress $address
     * @return bool
     */
    public function destroy(User $user, UserAddress $address): bool
    {
        return $user->isAuthOf($address);
    }
}
