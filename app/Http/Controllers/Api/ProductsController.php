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
        if ($category_id) {
            $category = Category::find($category_id);
        } else {
            $category = null;
        }
        $products = $this->productService->getProductListsByShopId($search, $order, $category, $shopId);
        $other = $this->productListsWithCategoryNameAndSubCategoryName($category);
        return $this->pageService->customPage($page, $size, $products, 'products', $other);
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


    /**
     * @param Category|null $category
     */
    protected function productListsWithCategoryNameAndSubCategoryName(Category $category = null)
    {
        $resultDataTemple = [];
        if (!is_null($category)) {
            $parentCategory = $category->ancestors;
            if ($parentCategory->isEmpty()) {
                $resultDataTemple['category_name'] = $category->id . '_' . $category->name;
            } else {
                $str = "";
                foreach ($parentCategory as $item) {
                    $str .= $item->id . '_' . $item->name . '_';
                }
                $str .= $category->id . '_' . $category->name;
//                dump($str);  1_手机配件_7_耳机_8_有线耳机
//                dd(explode('_', $str)); [ 0 => "1" , 1 => "手机配件"  2 => "7"  3 => "耳机"  4 => "8"  5 => "有线耳机"]
                $resultDataTemple['category_name'] = $str;
            }

            // 从这个可以区分是父目录查询还是子目录查询
            if ($category->is_directory) {
                $str = "";
                foreach ($category->children as $child) {
                    $str .= $child->id . '_' . $child->name . '_';
                }
                $resultDataTemple['sub_category_name'] = $str;
            }

        }

        return $resultDataTemple;
    }
}
