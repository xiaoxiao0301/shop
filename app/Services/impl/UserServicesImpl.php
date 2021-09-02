<?php

namespace App\Services\impl;

use App\Dict\ResponseJsonData;
use App\Exceptions\InvalidRequestException;
use App\Models\User;
use App\Models\UserAddress;
use App\Services\UserServicesIf;
use Cache;
use Hash;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
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


    /**
     * 保存用户收货地址
     *
     * @param $addressData
     * @return JsonResponse
     */
    public function saveUserAddress($addressData): JsonResponse
    {
        $address = new UserAddress($addressData);
        $user = $this->getUserInfoFromJwt();
        $address->user()->associate($user);
        $address->save();
        return ResponseJsonData::responseOk();
    }


    /**
     * 更新用户收货地址
     *
     * @param $address
     * @param $addressData
     * @return JsonResponse
     */
    public function updateUserAddress($address, $addressData): JsonResponse
    {
        $address->update($addressData);
        return ResponseJsonData::responseOk();
    }

    /**
     * 删除用户收货地址
     *
     * @param $address
     * @return JsonResponse
     */
    public function deleteUserAddress($address): JsonResponse
    {
        $address->delete();
        return ResponseJsonData::responseOk();
    }

    /**
     * 获取登陆用户的收货地址列表
     *
     * @return mixed
     */
    public function getLoginAddressLists()
    {
        $user = $this->getUserInfoFromJwt();
        // addresses 获取的是collection  addresses() 获取的是关联关系
        return $user->addresses->toArray();
    }

    /**
     * 收藏商品
     *
     * @param $product
     * @throws InvalidRequestException
     * @return JsonResponse
     */
    public function addFavoriteProduct($product): JsonResponse
    {
        $user = $this->getUserInfoFromJwt();
        if ($user->favoriteProducts()->find($product->id)) {
            throw new InvalidRequestException('商品已收藏');
        }
        $user->favoriteProducts()->attach($product);
        return ResponseJsonData::responseOk();
    }

    /**
     * 取消收藏
     *
     * @param $product
     * @return JsonResponse
     */
    public function deleteFavoriteProduct($product): JsonResponse
    {
        $user = $this->getUserInfoFromJwt();
        $user->favoriteProducts()->detach($product);
        return ResponseJsonData::responseOk();
    }

    /**
     * 收藏列表
     *
     * @return mixed
     */
    public function userFavoriteProductLists()
    {
        $user = $this->getUserInfoFromJwt();
        return $user->favoriteProducts->toArray();
    }

}
