<?php

namespace App\Services\impl;

use App\Services\PageServicesIf;

class PageServiceImpl implements PageServicesIf
{

    /**
     * 自定义分页
     *
     * @param $page
     * @param $size
     * @param $data
     * @return array
     */
    public function customPage($page, $size, $data): array
    {
        $resultDataTemple = [
            'data' => [],
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
        $resultDataTemple['data'] = $result;

        return $resultDataTemple;
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
