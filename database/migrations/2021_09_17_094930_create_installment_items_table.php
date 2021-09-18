<?php

use App\Models\InstallmentItem;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateInstallmentItemsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('installment_items', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('installment_id')->comment('分期ID');
            $table->foreign('installment_id')->references('id')->on('installments')->onDelete('cascade');
            $table->unsignedInteger('sequence')->comment('还款顺序编号');
            $table->decimal('base')->comment('当期本金');
            $table->decimal('fee')->comment('当期手续费');
            $table->decimal('fine')->comment('当前逾期费')->nullable();
            $table->dateTime('due_date')->comment('还款截止日期');
            $table->dateTime('paid_at')->comment('还款日期')->nullable();
            $table->string('payment_method')->comment('还款支付方式')->nullable();
            $table->string('payment_no')->comment('还款支付平台订单号')->nullable();
            $table->string('refund_status')->comment('退款状态')->default(InstallmentItem::REFUND_STATUS_PENDING);
            $table->timestamps();
        });
        DB::statement("alter table `installment_items` comment '还款计划表'");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('installment_items');
    }
}
