<?php

namespace App\Services\impl;

use App\Dict\ResponseJsonData;
use App\Services\PageServicesIf;
use Illuminate\Http\JsonResponse;

/**
 * 自定义分页
 */
class PageServicesImpl implements PageServicesIf
{
    /**
     * @param $page
     * @param $size
     * @param $data
     * @param $key
     * @param array $other
     * @return JsonResponse
     */
    public function customPage($page, $size, $data, $key, $other = []): JsonResponse
    {
        $resultDataTemple = [
            $key => [],
        ];
        if ($page < 1) {
            $page = 1;
        }
        $countNumber = count($data);
        $totalPage = ceil($countNumber / $size);
        if ($page > $countNumber) {
            $resultDataTemple['current_page'] = $page;
            $resultDataTemple['total_page'] = $totalPage;
        }
        [$start, $end] = $this->calcPageStartAndEnd($page, $size);
        $result = array_slice($data, $start, $end);
        $resultDataTemple['current_page'] = $page;
        $resultDataTemple['total_page'] = $totalPage;
        $resultDataTemple[$key] = $result;
        if ($other) {
            if (array_key_exists('category_name', $other)) {
                $resultDataTemple['category_name'] = $other['category_name'];
            }
            if (array_key_exists('sub_category_name', $other)) {
                $resultDataTemple['sub_category_name'] = $other['sub_category_name'];
            }
        }
        return ResponseJsonData::responseOk($resultDataTemple);
    }

    /**
     * 计算分页每页的起止位置
     *
     * @param $page
     * @param $size
     * @return array
     */
    protected function calcPageStartAndEnd($page, $size): array
    {
        $start = ($page - 1) * $size;
        $end = $start + $size;
        return [$start, $end];
    }
}
