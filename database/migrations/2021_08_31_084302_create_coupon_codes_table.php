<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCouponCodesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('coupon_codes', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name')->comment('优惠券标题');
            $table->string('code')->unique()->comment('优惠券码');
            $table->string('type')->comment('优惠类型, 固定金额和百分比折扣');
            $table->decimal('value')->comment('折扣值');
            $table->unsignedInteger('total')->comment('总量');
            $table->unsignedInteger('used')->default(0)->comment('当前已兑换的数量');
            $table->decimal('min_amount', 10, 2)->comment('使用该优惠券的最低订单金额');
            $table->timestamp('not_before')->nullable()->comment('在这个时间之前不可用');
            $table->timestamp('not_after')->nullable()->comment('在这个时间之后不可用');
            $table->boolean('enabled')->comment('是否有效');
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
        Schema::dropIfExists('coupon_codes');
    }
}
