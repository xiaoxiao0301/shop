<?php

namespace App\Services;

use App\Models\User;

interface UserServicesIf
{
    public function checkUserIsExistsByPhone(string $phone): bool;
    public function saveUsers(array $userData);
    public function getUserInfoByUserPhone(string $phone);
    public function getCurrentUserInfo();
}
