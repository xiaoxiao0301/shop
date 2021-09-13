<?php

namespace App\Http\Controllers\Api;


use App\Dict\ResponseJsonData;
use Illuminate\Http\JsonResponse;

class CategoriesController extends ApiBaseController
{
    /**
     * 获取后台设置的类目以及子类目
     * @return JsonResponse
     */
    public function getCategoryTree(): JsonResponse
    {
        $categories = $this->categoryService->getCategoryTree();
        return ResponseJsonData::responseOk($categories->toArray());
    }
}
