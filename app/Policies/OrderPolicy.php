<?php

namespace App\Policies;

use App\Models\Order;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class OrderPolicy
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
     * 只有创建订单的用户才能查看详情
     *
     * @param User $user
     * @param Order $order
     * @return bool
     */
    public function own(User $user, Order $order)
    {
        return $user->isAuthOf($order);
    }
}
