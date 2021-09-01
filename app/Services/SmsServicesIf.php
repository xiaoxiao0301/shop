<?php

namespace App\Services;

interface SmsServicesIf
{
    public function sendCode($phone);
}
