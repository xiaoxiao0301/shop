<?php

namespace App\Services;

interface UserServicesIf
{
    public function getUserInfoFromJwt();
    public function getUserInfoByPhone($phone);
    public function checkLoginCode($data);
    public function saveUser($phone);
}
