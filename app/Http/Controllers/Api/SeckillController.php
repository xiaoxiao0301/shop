<?php

namespace App\Http\Controllers\Api;


use App\Http\Requests\Api\SeckillOrderRequest;
use App\Models\ProductSku;
use App\Models\User;
use App\Models\UserAddress;
use Illuminate\Http\JsonResponse;

class SeckillController extends ApiBaseController
{
    /**
     * 创建秒杀订单
     *
     * @param SeckillOrderRequest $request
     * @return JsonResponse
     */
    public function store(SeckillOrderRequest $request): JsonResponse
    {
        /** @var User $user */
        $user = $this->userService->getUserInfoFromJwt();
        $sku = ProductSku::find($request->input('product_sku_id'));
        $address = $request->input('address');
        return $this->orderService->createSeckillOrder($user, $address, $sku);
    }
}
