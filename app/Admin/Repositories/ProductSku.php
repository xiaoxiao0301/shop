<?php

namespace App\Admin\Repositories;

use App\Models\ProductSku as Model;
use Dcat\Admin\Repositories\EloquentRepository;

class ProductSku extends EloquentRepository
{
    /**
     * Model.
     *
     * @var string
     */
    protected $eloquentClass = Model::class;
}
