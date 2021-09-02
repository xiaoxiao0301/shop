<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserAddressesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_addresses', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id')->comment('用户ID');
            // $table->foreign("user_id")->references("user_id")->on("users")->onDelete('cascade'); 这里使用了雪花算法
            $table->string("province")->comment("省");
            $table->string("city")->comment("市");
            $table->string("district")->comment("区");
            $table->string("address")->comment("详细地址");
            $table->unsignedInteger("zip")->comment("邮编");
            $table->string("contact_name")->comment("联系人姓名");
            $table->string("contact_phone")->comment("联系人电话");
            $table->dateTime("last_used_at")->nullable()->default(null)->comment("最后一次使用时间");
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
        Schema::dropIfExists('user_addresses');
    }
}
