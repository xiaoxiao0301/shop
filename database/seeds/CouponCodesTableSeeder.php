<?php

use App\Models\CouponCode;
use Illuminate\Database\Seeder;

class CouponCodesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(CouponCode::class, 20)->create();
    }
}
