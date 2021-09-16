<?php

namespace App\Http\Controllers\Api;

use App\Http\Requests\Api\CrowdFundingOrderRequest;
use App\Models\Order;
use App\Models\ProductSku;
use App\Models\User;
use App\Models\UserAddress;
use Illuminate\Http\JsonResponse;
use Throwable;

class CrowdFundingOrderController extends ApiBaseController
{
    /**
     * 创建众筹订单
     *
     * @param CrowdFundingOrderRequest $request
     * @return JsonResponse
     * @throws Throwable
     */
    public function store(CrowdFundingOrderRequest $request): JsonResponse
    {
        /** @var User $user */
        $user = $this->userService->getUserInfoFromJwt();
        $sku = ProductSku::find($request->input('product_sku_id'));
        $address = UserAddress::find($request->input('address_id'));
        $amount = $request->input('amount');
        return $this->orderService->createCrowdfundingOrder($user, $address, $sku, $amount);
    }
}
