<?php

namespace App\Http\Controllers\Api;

use App\dict\Codes;
use App\Http\Requests\Api\UserAddressRequest;
use App\Http\Resources\UserAddress as UserAddressResource;
use App\Models\User;
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
        if ($page < 1) {
            $page = 1;
        }
        $userId = $this->userSerivce->getCurrentUserInfo()->user_id;
        $userAddresses = $this->userAddressService->getUserAddressListsByUserId($userId)->toArray();
        $countNumber = count($userAddresses);
        [$start, $end] = $this->calcPageStartAndEnd($page, $size);
        $address = array_slice($userAddresses, $start, $end);


        return $this->responseData(Codes::CODE_SUCCESS,
            Codes::getMessageByCode(Codes::CODE_SUCCESS),
            [
                "current_page" => $page,
                "total_page" => ceil($countNumber / $size),
                "address" => $address
            ],
            Codes::STATUS_CODE_OK
        );

    }

    /**
     * 创建用户收货地址
     *
     * @param UserAddressRequest $request
     * @return JsonResponse
     */
    public function store(UserAddressRequest $request)
    {
        $data = $request->all();
        $addressInfo = [
            'province' => $data["province"],
            'city' => $data["city"],
            'district' => $data["district"],
            'address' => $data["address"],
            'zip' => $data["zip"],
            'contact_name' => $data["contact_name"],
            'contact_phone' => $data["contact_phone"],
        ];
        $addressInfo["user_id"] = $this->userSerivce->getCurrentUserInfo()->user_id;
        $result = $this->userAddressService->saveUserAddress($addressInfo);
        return $this->responseData(Codes::CODE_SUCCESS,
            Codes::getMessageByCode(Codes::CODE_SUCCESS),
            collect($result)->toArray(),
            Codes::STATUS_CODE_CREATED
        );
    }


    /**
     * 更新用户收货地址
     *
     * @param UserAddressRequest $request
     * @param UserAddress $address
     * @return JsonResponse
     */
    public function update(UserAddressRequest $request, UserAddress $address)
    {
        try {
            $this->authorize('update', $address);
            $data = $request->all();
            $result = $this->userAddressService->updateUserAddress($address, $data);
            if ($result) {
                return $this->responseData(Codes::CODE_SUCCESS,
                    Codes::getMessageByCode(Codes::CODE_SUCCESS),
                    [],
                    Codes::STATUS_CODE_CREATED
                );
            } else {
                Log::error("更新用户收货地址出错", [
                    "want-edit-address" => $address,
                    "edit-address-data" => $data
                ]);
                return $this->responseData(Codes::CODE_NETWORK_BUSY,
                    Codes::getMessageByCode(Codes::CODE_NETWORK_BUSY),
                    [],
                    Codes::STATUS_CODE_ERROR_INTERNAL
                );
            }
        } catch (AuthorizationException $authorizationException) {
            return response()->json([
                "code" => Codes::CODE_ACTION_NOT_ALLOWED,
                "message" => Codes::getMessageByCode(Codes::CODE_ACTION_NOT_ALLOWED),
                "data" => []
            ])->setStatusCode(Codes::STATUS_CODE_FORBIDDEN);
        }

    }


    /**
     * 删除用户收货地址
     *
     * @param UserAddress $address
     * @return JsonResponse
     */
    public function destroy(UserAddress $address)
    {
       try {
            $this->authorize("destroy", $address);
            $result = $this->userAddressService->deleteUserAddress($address);
            if ($result) {
                return $this->responseData(Codes::CODE_SUCCESS,
                    Codes::getMessageByCode(Codes::CODE_SUCCESS),
                    [],
                    Codes::STATUS_CODE_OK
                );
            } else {
                Log::error("删除用户收货地址出错", [
                    "want-delete-address" => $address,
                ]);
                return $this->responseData(Codes::CODE_NETWORK_BUSY,
                    Codes::getMessageByCode(Codes::CODE_NETWORK_BUSY),
                    [],
                    Codes::STATUS_CODE_ERROR_INTERNAL
                );
            }

        } catch (AuthorizationException $exception) {
            return response()->json([
                "code" => Codes::CODE_ACTION_NOT_ALLOWED,
                "message" => Codes::getMessageByCode(Codes::CODE_ACTION_NOT_ALLOWED),
                "data" => []
            ])->setStatusCode(Codes::STATUS_CODE_FORBIDDEN);
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
        [$offset, $limit] = $this->calcPageStartAndEnd($page, $size);
        $addresses = $this->userAddressService->getUserAddressListsByUserIdAndPageAndSize($userId, $offset, $limit);
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
        $addresses = $this->userAddressService->getUserAddressListsByUserIdAndPageSize($userId, 20);
        return UserAddressResource::collection($addresses)->additional([
            'code' => Codes::CODE_SUCCESS,
            'message' => Codes::getMessageByCode(Codes::CODE_SUCCESS)
        ]);
    }
}
