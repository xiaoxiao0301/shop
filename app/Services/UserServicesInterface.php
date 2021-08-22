<?php

namespace App\Services;

use App\Models\User;

interface UserServicesInterface
{
    public function checkUserIsExistsByPhone(string $phone): bool;
    public function saveUsers(User $user): User;
    public function getUserInfoByUserPhone(string $phone);
}
