<?php

namespace App\Services;

interface TokenServicesIf
{
    public function generateToken($user);
    public function refreshToken($token);

}
