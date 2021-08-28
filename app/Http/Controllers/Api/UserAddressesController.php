<?php

namespace App\Http\Controllers\Api;

use App\dict\Codes;
use App\Http\Requests\Api\UserAddressRequest;
use App\Http\Resources\UserAddress as UserAddressResource;
use App\Models\UserAddress;

use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Facades\Log;

class UserAddressesController extends BaseController
{

    /**
     * 收货地址列表, 自定义分页，array_slice
     *
     * @param UserAddressRequest $request
     * @return JsonResponse
     */
    public function list(UserAddressRequest $request): JsonResponse
    {
        $page = $request->get('page');
        $size = $request->get('size');
        $userAddresses = $this->userService->getUserAddressesList();
        $result = $this->pageService->customPage($page, $size, $userAddresses);
        if (!$result["data"]) {
            $httpCode = Codes::STATUS_CODE_NOT_FOUND;
        } else {
            $httpCode = Codes::STATUS_CODE_OK;
        }

        return $this->responseData(Codes::CODE_SUCCESS, $result, $httpCode);

    }

    /**
     * 创建用户收货地址
     *
     * @param UserAddressRequest $request
     * @return JsonResponse
     */
    public function store(UserAddressRequest $request): JsonResponse
    {
        $addressInfo = $request->except([
            'province', 'city', 'district', 'address',
            'zip', 'contact_name', 'contact_phone',
        ]);
        $userAddress = new UserAddress($addressInfo);
        $this->userService->saveUserAddress($userAddress);
        return $this->responseData(Codes::CODE_SUCCESS, [], Codes::STATUS_CODE_CREATED);
    }


    /**
     * 更新用户收货地址
     *
     * @param UserAddressRequest $request
     * @param UserAddress $address
     * @return JsonResponse
     */
    public function update(UserAddressRequest $request, UserAddress $address): JsonResponse
    {
        try {
            $this->authorize('update', $address);
            $data = $request->all();
            $result = $this->userService->updateUserAddress($address, $data);
            if ($result) {
                return $this->responseData(Codes::CODE_SUCCESS, [], Codes::STATUS_CODE_CREATED);
            } else {
                Log::error("更新用户收货地址出错", [
                    "want-edit-address" => $address,
                    "edit-address-data" => $data
                ]);
                return $this->responseData(Codes::CODE_NETWORK_BUSY, [], Codes::STATUS_CODE_ERROR_INTERNAL);
            }
        } catch (AuthorizationException $authorizationException) {
            return $this->responseData(Codes::CODE_ACTION_NOT_ALLOWED, [], Codes::STATUS_CODE_FORBIDDEN);
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
            $this->authorize("destroy", $address);
            $result = $this->userService->deleteUserAddress($address);
            if ($result) {
                return $this->responseData(Codes::CODE_SUCCESS, [], Codes::STATUS_CODE_OK);
            } else {
                Log::error("删除用户收货地址出错", [
                    "want-delete-address" => $address,
                ]);
                return $this->responseData(Codes::CODE_NETWORK_BUSY, [], Codes::STATUS_CODE_ERROR_INTERNAL);
            }

        } catch (AuthorizationException $exception) {
           return $this->responseData(Codes::CODE_ACTION_NOT_ALLOWED, [], Codes::STATUS_CODE_FORBIDDEN);
        }
    }


    /**
     * 获取用户收货地址列表 mysql-limit-offset
     *
     * @param $page
     * @param $size
     * @param $userId
     * @return AnonymousResourceCollection
     */
    protected function getAddressResponseResource($page, $size, $userId): AnonymousResourceCollection
    {
        if ($page < 1) {
            $page = 1;
        }
        $offset = ($page - 1) * $size;
        $limit = $offset + $size;
        $addresses = $this->userService->getUserAddressListsByUserIdAndPageAndSize($userId, $offset, $limit);
        return UserAddressResource::collection($addresses)->additional([
            'code' => Codes::CODE_SUCCESS,
            'message' => Codes::getMessageByCode(Codes::CODE_SUCCESS)
        ]);
    }

    /**
     * 获取当前用户的所有收货地址, laravel-pagination
     *
     * @param $userId
     * @return AnonymousResourceCollection
     */
    protected function getAddressesList($userId): AnonymousResourceCollection
    {
        $addresses = $this->userService->getUserAddressListsByUserIdAndPageSize($userId, 20);
        return UserAddressResource::collection($addresses)->additional([
            'code' => Codes::CODE_SUCCESS,
            'message' => Codes::getMessageByCode(Codes::CODE_SUCCESS)
        ]);
    }
}
