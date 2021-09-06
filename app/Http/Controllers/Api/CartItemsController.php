<?php

namespace App\Http\Controllers\Api;

use App\Dict\ResponseJsonData;
use App\Http\Requests\Api\CartItemRequest;
use App\Models\ProductSku;
use Illuminate\Http\JsonResponse;

class CartItemsController extends ApiBaseController
{

    /**
     * 添加商品到购物车
     *
     * @param CartItemRequest $request
     * @return JsonResponse
     */
    public function store(CartItemRequest $request): JsonResponse
    {
        $amount = $request->input('amount');
        $productSkuId = $request->input('sku_id');
        return $this->userService->addProductToCartItem($productSkuId, $amount);
    }

    /**
     * 购物车列表
     *
     * @return JsonResponse
     */
    public function index(): JsonResponse
    {
        $carts = $this->userService->getUserCartItemLists();
        $addresses = $this->userService->getLoginAddressLists();
        return ResponseJsonData::responseOk(compact('carts', 'addresses'));
    }


    /**
     * 从购物车移除商品
     *
     * @param ProductSku $sku
     * @return JsonResponse
     */
    public function destroy(ProductSku $sku): JsonResponse
    {
        return $this->userService->deleteProductFromCartItem($sku->id);
    }
}
