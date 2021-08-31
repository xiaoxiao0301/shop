<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class OrdersAddCouponCodeId extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->unsignedBigInteger('coupon_code_id')->nullable()->after('paid_at');
            $table->foreign('coupon_code_id')->references('id')->on('coupon_codes')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('orders', function (Blueprint $table) {
            // 字符串则代表删除外键名  数组的话则会删除该数组中字段所对应的外键
            $table->dropForeign(['coupon_code_id']);
            $table->dropColumn('coupon_code_id');
        });
    }
}
