<?php

namespace Database\Seeders;

use App\Models\Product;
use App\Models\User;
use Illuminate\Database\Seeder;

class UserFavoriteProductsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $users = User::factory()->times(15)->create();
        foreach ($users as $user) {
            $products = Product::factory(random_int(1, 5))->create();
            $user->favoriteProducts()->attach($products);
        }
        $user = User::find(1);
        $products = Product::factory()->times(15)->create();
        $user->favoriteProducts()->attach($products);
    }
}
