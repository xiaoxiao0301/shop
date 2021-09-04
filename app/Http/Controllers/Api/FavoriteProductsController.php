<?php

namespace App\Http\Controllers\Api;

use App\Http\Requests\Api\PageRequest;
use App\Models\Product;
use Illuminate\Http\JsonResponse;

class FavoriteProductsController extends ApiBaseController
{
    /**
     * 收藏商品
     *
     * @param Product $product
     * @return JsonResponse
     */
    public function store(Product $product): JsonResponse
    {
        return $this->userService->addFavoriteProduct($product);
    }

    /**
     * 取消收藏
     *
     * @param Product $product
     * @return JsonResponse
     */
    public function destroy(Product $product): JsonResponse
    {
        return $this->userService->deleteFavoriteProduct($product);
    }


    /**
     * 收藏列表
     *
     * @param PageRequest $request
     * @return JsonResponse
     */
    public function index(PageRequest $request): JsonResponse
    {
        $page = $request->input('page');
        $size = $request->input('size');
        $products = $this->userService->userFavoriteProductLists();
        return $this->pageService->customPage($page, $size, $products, 'favorites');
    }
}
