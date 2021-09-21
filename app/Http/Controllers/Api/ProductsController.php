<?php

namespace App\Http\Controllers\Api;


use App\Dict\ResponseJsonData;
use App\Exceptions\InvalidRequestException;
use App\Http\Requests\Api\PageRequest;
use App\Models\Category;
use App\Models\Product;
use Illuminate\Http\JsonResponse;

class ProductsController extends ApiBaseController
{
    /**
     * 商品列表
     *
     * @param PageRequest $request
     * @return JsonResponse
     */
    public function index(PageRequest $request, $shopId = null): JsonResponse
    {
        $page = $request->input('page');
        $size = $request->input('size');
        $search =  $request->input('search') ?? null;
        $order = $request->input('order') ?? null;
        $category_id = $request->input('category_id');
        // ?filters=传输类型:DDR4|内存容量:32GB
        $filter = $request->input('filter') ?? null;
        if ($category_id) {
            $category = Category::find($category_id);
        } else {
            $category = null;
        }
//        $products = $this->productService->getProductListsByShopId($search, $order, $category, $shopId);
        return $this->productService->getProductListsFromEs($page, $size, $search, $order, $category, $filter, $shopId);
//        $other = $this->productListsWithCategoryNameAndSubCategoryName($category);
//        return $this->pageService->customPage($page, $size, $products, 'products', $other);
    }


    /**
     * 商品详情，包含sku
     *
     * @param Product $product
     * @return JsonResponse
     * @throws InvalidRequestException
     */
    public function show(Product $product): JsonResponse
    {
        $result = $this->productService->getProductDetail($product);
        $collected = $this->userService->checkUserHasCollectProduct($product);
        $result['favorited'] = $collected;
        return ResponseJsonData::responseOk($result);
    }
}
