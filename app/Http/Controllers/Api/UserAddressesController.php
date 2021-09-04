<?php

namespace App\Http\Controllers\Api;

use App\Dict\ResponseJsonData;
use App\Http\Requests\Api\PageRequest;
use App\Http\Requests\Api\UserAddressRequest;
use App\Models\UserAddress;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Http\JsonResponse;

class UserAddressesController extends ApiBaseController
{
    /**
     * 保存收货地址
     *
     * @param UserAddressRequest $request
     * @return JsonResponse
     */
    public function store(UserAddressRequest $request): JsonResponse
    {
        $data = $request->only([
            'province',
            'city',
            'district',
            'address',
            'zip',
            'contact_name',
            'contact_phone',
        ]);

        return $this->userService->saveUserAddress($data);
    }

    /**
     * 更新用户收货地址
     *
     * @param UserAddress $address
     * @param UserAddressRequest $request
     * @return JsonResponse
     */
    public function update(UserAddress $address, UserAddressRequest $request): JsonResponse
    {
        try {
            $this->authorize('update', $address);
            $data = $request->only([
                'province',
                'city',
                'district',
                'address',
                'zip',
                'contact_name',
                'contact_phone',
            ]);
            return $this->userService->updateUserAddress($address, $data);
        } catch (AuthorizationException $exception) {
            return ResponseJsonData::responseUnAuthorization("无权限执行");
        }
    }

    /**
     * 删除用户收货地址
     *
     * @param UserAddress $address
     * @return JsonResponse
     */
    public function destroy(UserAddress $address): JsonResponse
    {
        try {
            $this->authorize('destroy', $address);
            return $this->userService->deleteUserAddress($address);
        } catch (AuthorizationException $exception) {
            return ResponseJsonData::responseUnAuthorization("无权限执行");
        }
    }


    public function index(PageRequest $request)
    {
        $page = $request->input('page');
        $size = $request->input('size');
        $address = $this->userService->getLoginAddressLists();
        return $this->pageService->customPage($page, $size, $address, 'address');
    }
}
