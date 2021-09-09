<?php

namespace App\Admin\Repositories;

use Dcat\Admin\Repositories\QueryBuilderRepository;

class ApplyRefundRepositories extends QueryBuilderRepository
{
    // 设置你的主键名称
    protected $keyName = 'id';

    // 设置创建时间字段
    protected $createdAtColumn = 'created_at';

    // 设置更新时间字段
    protected $updatedAtColumn = 'updated_at';

    // 返回表名
    public function getTable()
    {
        return 'orders';
    }

    // 返回你的主键名称
    public function getKeyName()
    {
        return $this->keyName;
    }

    // 通过这个方法可以指定查询的字段，默认"*"
    public function getGridColumns()
    {
        return ['*'];
    }

    // 通过这个方法可以指定表单页查询的字段，默认"*"
    public function getFormColumns()
    {
        return ['*'];
    }

    // 通过这个方法可以指定数据详情页查询的字段，默认"*"
    public function getDetailColumns()
    {
        return ['*'];
    }
}
