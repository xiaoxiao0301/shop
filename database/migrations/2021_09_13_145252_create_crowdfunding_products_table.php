<?php

use App\Models\CrowdfundingProduct;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCrowdfundingProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('crowdfunding_products', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('product_id')->comment('商品表ID');
            $table->foreign('product_id')->references('id')->on('products')->onDelete('cascade');
            $table->decimal('target_amount', 10, 2)->comment('众筹目标金额');
            $table->decimal('total_amount', 10, 2)->default(0)->comment('已众筹金额');
            $table->unsignedInteger('user_count')->default(0)->comment('当前众筹人数');
            $table->dateTime('end_time')->nullable()->comment('众筹截止时间');
            $table->string('status')->default(CrowdfundingProduct::STATUS_FUNDING)->comment('筹款状态');
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
        Schema::dropIfExists('crowdfunding_products');
    }
}
