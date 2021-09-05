<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCouponsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('coupons', function (Blueprint $table) {
            $table->id();
            // 标题， 简介， 码， 数量，已领取  已用， 开始使用时间 结束使用时间 类型：折扣还是满减 最小订单金额  折扣值 店铺id 是否可用
            $table->string('title')->comment('标题');
            $table->string('description')->comment('简介');
            $table->string('code')->comment('码')->unique();
            $table->unsignedInteger('total_number')->comment('数量');
            $table->unsignedInteger('got_number')->comment('已领取')->default(0);
            $table->unsignedInteger('used_number')->comment('已用')->default(0);
            $table->dateTime('start_time')->nullable()->comment('开始使用时间');
            $table->dateTime('end_time')->nullable()->comment('结束使用时间');
            $table->string('type')->comment('类型, 折扣还是满减');
            $table->decimal('value')->comment('折扣值');
            $table->decimal('min_amount')->comment('最小订单金额');
            $table->boolean('is_available')->default(false)->comment('是否可用');
            $table->unsignedBigInteger('shop_id')->nullable()->comment('店铺id');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('coupons');
    }
}
