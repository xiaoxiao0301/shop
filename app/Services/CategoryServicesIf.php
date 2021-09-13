<?php

namespace App\Services;

interface CategoryServicesIf
{
    public function getCategoryTree($parentId = null, $allCategories = null);
}
