<?php

namespace App\Http\Controllers\Api;

use App\dict\Codes;
use App\Http\Requests\Api\PageRequest;
use App\Models\Product;
use Illuminate\Http\JsonResponse;

class ProductsController extends BaseController
{
    /**
     * 获取商品列表
     *
     * @param PageRequest $request
     * @return JsonResponse
     */
    public function list(PageRequest $request): JsonResponse
    {
        $search = $request->get("search");
        $order = $request->get("order");
        $page = $request->get('page');
        $size = $request->get('size');
        // 排序 price 价钱/sold_count 销量/rating 评分_asc|desc
        $products = $this->productService->getProductsByQuery($search, $order)->toArray();
        $result = $this->pageService->customPage($page, $size, $products);
        if (!$result["data"]) {
            $httpCode = Codes::STATUS_CODE_NOT_FOUND;
        } else {
            $httpCode = Codes::STATUS_CODE_OK;
        }

        return $this->responseData(Codes::CODE_SUCCESS, $result, $httpCode);
    }

    /**
     * 商品详情
     *
     * @param Product $product
     * @return JsonResponse
     */
    public function show(Product $product): JsonResponse
    {
        // 商品检验，必须是后台上架的产品
        if (!$product->on_sale) {
            return $this->responseData(Codes::CODE_PRODUCT_INVALID, [], Codes::STATUS_CODE_BAD_REQUEST);
        }
        // 获取商品的sku , 动态属性是懒加载
        $skus = $product->skus->toArray();

        // 用户是否收藏当前商品
        $favored = $this->userService->checkUserCollectProduct($product);

        return $this->responseData(Codes::CODE_SUCCESS,
            [
                "product" => $product,
                "skus" => $skus,
                "favored" => $favored,
            ],
            Codes::STATUS_CODE_OK
        );
    }

    /**
     * 收藏商品
     *
     * @param Product $product
     * @return JsonResponse
     */
    public function favor(Product $product): JsonResponse
    {
        $user = $this->userService->getCurrentUserInfo();
        // 判断用户是否重复收藏
        if (!$this->productService->favoriteProduct($user, $product)) {
            return $this->responseData(Codes::CODE_PRODUCT_ADD_FAVORITE, [], Codes::STATUS_CODE_FORBIDDEN);
        }
        return $this->responseData(Codes::CODE_SUCCESS, [], Codes::STATUS_CODE_OK);
    }


    /**
     * 取消收藏商品
     *
     * @param Product $product
     * @return JsonResponse
     */
    public function disfavor(Product $product): JsonResponse
    {
        $user = $this->userService->getCurrentUserInfo();
        $result = $this->productService->disFavoriteProduct($user, $product);
        if ($result === 0) {
            return $this->responseData(Codes::CODE_PRODUCT_NOT_FAVORITE, [], Codes::STATUS_CODE_FORBIDDEN);
        }
        return $this->responseData(Codes::CODE_SUCCESS, [], Codes::STATUS_CODE_OK);
    }


    /**
     * 收藏商品列表
     *
     * @param PageRequest $request
     * @return JsonResponse
     */
    public function favoriteList(PageRequest $request): JsonResponse
    {
        $page = $request->get('page');
        $size = $request->get('size');
        $list = $this->userService->getUserCollectProductLists();
        $result = $this->pageService->customPage($page, $size, $list);
        if (!$result["data"]) {
            $httpCode = Codes::STATUS_CODE_NOT_FOUND;
        } else {
            $httpCode = Codes::STATUS_CODE_OK;
        }

        return $this->responseData(Codes::CODE_SUCCESS, $result, $httpCode);
    }

}
