<?php

namespace App\Services\impl;

use App\Models\Category;
use App\Services\CategoryServicesIf;
use Illuminate\Support\Collection;

class CategoryServicesImpl implements CategoryServicesIf
{
    /**
     * @param null $parentId
     * @param null $allCategories
     * @return Collection
     */
    public function getCategoryTree($parentId = null, $allCategories = null): Collection
    {
        // 第一次需要获取所有的分类
        if (is_null($allCategories)) {
            $allCategories = Category::all();
        }

        return $allCategories
            // 第一次是帅选出主目录
            ->where('parent_id', $parentId)
            ->map(function (Category $category) use ($allCategories) {
                $data = [
                    'id' => $category->id,
                    'name' => $category->name,
                ];
                if ($category->is_directory) {
                    $data['has_children'] = true;
                    $data['children'] = $this->getCategoryTree($category->id, $allCategories);
                }
                return $data;
            });
    }
}
