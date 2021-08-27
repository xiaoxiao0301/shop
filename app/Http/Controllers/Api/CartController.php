<?php

namespace App\Http\Controllers\Api;

use App\dict\Codes;
use App\Http\Requests\Api\CartRequest;
use App\Http\Requests\Api\PageRequest;
use App\Models\ProductSku;
use Illuminate\Http\JsonResponse;

class CartController extends BaseController
{
    /**
     * 购物车添加商品
     *
     * @param CartRequest $request
     * @return JsonResponse
     */
    public function store(CartRequest $request): JsonResponse
    {
        $user = $this->userService->getCurrentUserInfo();
        $skuId = $request->get('sku_id');
        $amount = $request->get('amount');
        $result = $this->cartItemService->addProductToCart($user, $skuId, $amount);
        if (!$result) {
            $code = Codes::CODE_INVALID_PARAM;
            $httpCode = Codes::STATUS_CODE_ERROR_INTERNAL;
        } else {
            $code = Codes::CODE_SUCCESS;
            $httpCode = Codes::STATUS_CODE_OK;
        }
        return $this->responseData($code, [], $httpCode);
    }


    /**
     * 购物车列表
     *
     * @param PageRequest $request
     * @return JsonResponse
     */
    public function list(PageRequest $request): JsonResponse
    {
        $page = $request->get('page');
        $size = $request->get('size');
        $user = $this->userService->getCurrentUserInfo();
        $carts = $this->cartItemService->getCartLists($user);
        $result = $this->pageService->customPage($page, $size, $carts);
        if (!$result["data"]) {
            $httpCode = Codes::STATUS_CODE_NOT_FOUND;
        } else {
            $httpCode = Codes::STATUS_CODE_OK;
        }

        return $this->responseData(Codes::CODE_SUCCESS, $result, $httpCode);
    }

    /**
     * 从购物车移除商品
     *
     * @param ProductSku $sku
     * @return JsonResponse
     */
    public function destroy(ProductSku $sku): JsonResponse
    {
        // 这里不做权限校验是因为同一件商品可以被多人添加到各自的购物车中
        $user = $this->userService->getCurrentUserInfo();
        $this->cartItemService->removeProductFromCart($user, $sku);
        return $this->responseData(Codes::CODE_SUCCESS, [], Codes::STATUS_CODE_OK);
    }
}
