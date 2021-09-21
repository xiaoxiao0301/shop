<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Category extends Model
{

    protected $fillable = ['name', 'is_directory', 'level', 'path'];

    protected $casts = [
        'is_directory' => 'boolean',
    ];

    protected static function boot()
    {
        parent::boot();
        static::creating(function (Category $category) {
            if (is_null($category->parent_id)) {
                // 将层级设为 0
                $category->level = 0;
                // 将 path 设为 -
                $category->path = '-';
            } else {
                // 将层级设为父类目的层级 + 1
                $category->level = $category->level + 1;
                // 将 path 值设为父类目的 path 追加父类目 ID 以及最后跟上一个 - 分隔符
                $category->path = $category->parent->path.$category->parent_id.'-';
            }
        });
    }

    /**
     * @return BelongsTo
     */
    public function parent(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    /**
     * @return HasMany
     */
    public function children(): HasMany
    {
        return $this->hasMany(Category::class, 'parent_id');
    }

    /**
     * 关联商品 一对多
     *
     * @return HasMany
     */
    public function products(): HasMany
    {
        return $this->hasMany(Product::class);
    }

    /**
     * 获取所有祖先类目的 ID 值
     *
     * @return false|string[]
     */
    public function getPathIdsAttribute()
    {
        // trim($str, '-') 将字符串两端的 - 符号去除
        // explode() 将字符串以 - 为分隔切割为数组
        // 最后 array_filter 将数组中的空值移除
        return array_filter(explode('-', trim($this->path, '-')));
    }

    /**
     * 获取所有祖先类目并按层级排序
     *
     * @return Builder[]|Collection
     */
    public function getAncestorsAttribute()
    {
        return Category::query()
            // 使用上面的访问器获取所有祖先类目 ID
            ->whereIn('id', $this->path_ids)
            // 按层级排序
            ->orderBy('level')
            ->get();
    }


    /**
     * 获取以 - 为分隔的所有祖先类目名称以及当前类目的名称
     *
     * @return mixed
     */
    public function getFullNameAttribute()
    {
        return $this->ancestors  // 获取所有祖先类目
        ->pluck('name') // 取出所有祖先类目的 name 字段作为一个数组
        ->push($this->name) // 将当前类目的 name 字段值加到数组的末尾
        ->implode('-'); // 用 - 符号将数组的值组装成一个字符串
    }


    /**
     *  一些阅读：
     *
     * [
        [
            "id" => 1,
            "name" => "手机配件",
            "parent_id" => null,
            "level" => 0,
            "path" => "-"
        ],
        [
            "id" => 2,
            "name" => "耳机",
            "parent_id" => 1,
            "level" => 1,
            "path" => "-1-"
        ],
        [
            "id" => 3,
            "name" => "蓝牙耳机",
            "parent_id" => 2,
            "level" => 2,
            "path" => "-1-2-"
        ],
        [
            "id" => 4,
            "name" => "移动电源",
            "parent_id" => 1,
            "level" => 1,
            "path" => "-1-"
        ],
    ]
    上面对应的类目如下：
        手机配件(1)
        ├─ 耳机(2)
        │   └─ 蓝牙耳机(3)
        └─ 移动电源(4)
    查询『蓝牙耳机』的所有祖先类目：取出 path 字段的值 -1-2-，以 - 为分隔符分割字符串并过滤掉空值，得到数组 [1, 2] ，然后使用 Category::whereIn('id', [1, 2])->orderBy('level')->get() 即可获得排好序的所有父类目。
    查询『手机配件』的所有后代类目：取出自己的 path 值 -，然后追加上自己的 ID 字段得到 -1-，然后使用 Category::where('path', 'like', '-1-%')->get() 即可获得所有后代类目。
    判断『移动电源』与『蓝牙耳机』是否有祖孙关系：取出两者中 level 值较大的类目『蓝牙耳机』的 path 值 -1-2- 并赋值给变量 $highLevelPath，取另外一个类目的 path 值并追加该类目的 ID 得 -1-4- 并赋值给变量 $lowLevelPath，然后只需要判断变量 $highLevelPath 是否以 $lowLevelPath 开头，如果是则有祖孙关系。
    新增一个冗余的 path 字段，就能很好地解决性能问题，这是一种很典型的（存储）空间换（执行）时间策略。
     */
}
