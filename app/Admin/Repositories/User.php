<?php

namespace App\Admin\Repositories;

use App\Models\User as Model;
use Dcat\Admin\Repositories\EloquentRepository;

class User extends EloquentRepository
{
    /**
     * Model.
     *
     * @var string
     */
    protected $eloquentClass = Model::class;

    /**
     * 设置表格查询的字段，默认查询所有字段
     *
     * @return string[]
     */
    public function getGridColumns()
    {
        return ['id', 'user_id', 'phone', 'created_at'];
    }
}
