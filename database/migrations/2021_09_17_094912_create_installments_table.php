<?php

use App\Models\Installment;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateInstallmentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {

        Schema::create('installments', function (Blueprint $table) {
            $table->id();
            $table->string('no')->unique()->comment('分期流水号');
            $table->unsignedBigInteger('user_id')->comment('用户编号');
//            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->unsignedBigInteger('order_id')->comment('订单ID');
//            $table->foreign('order_id')->references('id')->on('orders')->onDelete('cascade');
            $table->decimal('total_amount')->comment('总本金');
            $table->unsignedInteger('count')->comment('还款期数');
            $table->float('fee_rate')->comment('手续费率');
            $table->float('fine_rate')->comment('逾期费率');
            $table->string('status')->comment('还款状态')->default(Installment::STATUS_PENDING);
            $table->timestamps();
        });
        DB::statement("alter table `installments` comment '分期信息表'");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('installments');
    }
}
