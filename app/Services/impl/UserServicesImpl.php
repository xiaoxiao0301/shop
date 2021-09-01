<?php

namespace App\Services\impl;

use App\Exceptions\InvalidRequestException;
use App\Models\User;
use App\Services\UserServicesIf;
use Cache;
use Hash;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Str;

class UserServicesImpl implements UserServicesIf
{
    /**
     * 从jwt获取登录用户信息
     *
     * @return Authenticatable|null
     */
    public function getUserInfoFromJwt(): Authenticatable
    {
        return auth()->user();
    }

    /**
     * 根据手机号查询用户信息
     *
     * @param $phone
     * @return Builder|Model|object|null
     */
    public function getUserInfoByPhone($phone)
    {
        return User::query()->where('phone', $phone)->first();
    }

    /**
     * 判断验证码正确性，手机号没有用户就创建
     *
     * @param $data
     * @return Builder|Model|mixed|object|null
     * @throws InvalidRequestException
     */
    public function checkLoginCode($data)
    {
        $codeKey = $data['code_key'];
        $codeCacheInfo = Cache::get($codeKey);
        if (!$codeCacheInfo) {
            throw new InvalidRequestException('验证码key已过期');
        }

        if ($codeCacheInfo['code'] != $data['code']) {
            Cache::forget($codeKey);
            throw new InvalidRequestException('验证码错误');
        }

        $phone = $codeCacheInfo['phone'];

        // 清楚短信验证码key
        Cache::forget($codeKey);

        $user = $this->getUserInfoByPhone($phone);
        if (!$user) {
            $user = $this->saveUser($phone);
        }

        return $user;
    }

    /**
     * 创建用户
     *
     * @param $phone
     * @return mixed
     */
    public function saveUser($phone)
    {
        $userData = [
            "name" => "boy_" . Str::random(5),
            "phone" => $phone,
            "password" => Hash::make('password'),
        ];

        return User::create($userData);
    }
}
