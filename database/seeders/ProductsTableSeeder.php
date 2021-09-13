<?php

namespace Database\Seeders;

use App\Models\Category;
use App\Models\Product;
use App\Models\ProductSku;
use Illuminate\Database\Seeder;

class ProductsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $products = Product::factory()->times(30)->create();
        foreach ($products as $product) {
            $skus = ProductSku::factory(random_int(1, 5))->create(['product_id' => $product->id]);
            $product->update(['price' => $skus->min('price')]);
        }

//        $products = Product::all();
//        foreach ($products as $product) {
//            $category = Category::query()->where('is_directory', false)->inRandomOrder()->first();
//            $product->category()->associate($category);
//            $product->save();
//        }
    }
}
