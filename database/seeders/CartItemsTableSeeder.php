<?php

namespace Database\Seeders;

use App\Models\ProductSku;
use App\Models\User;
use Illuminate\Database\Seeder;

class CartItemsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {

        $users = User::query()->where('id', '>', 1)->limit(10)->get();
        foreach ($users as $user) {
            $skus = ProductSku::query()->inRandomOrder()->first();
            /** @var User $user */
            $user->cartItems()->create([
                'product_sku_id' => $skus->id,
                'amount' => random_int(1, 10)
            ]);
        }
    }
}
