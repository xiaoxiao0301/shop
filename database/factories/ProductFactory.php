<?php

namespace Database\Factories;

use App\Models\Category;
use App\Models\Product;
use Illuminate\Database\Eloquent\Factories\Factory;

class ProductFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Product::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        $productImages = [
            "https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg",
            "https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg",
            "https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg",
            "https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg",
            "https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg",
            "https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg",
            "https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg",
            "https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg",
            "https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg",
            "https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg",
        ];

        $category = Category::query()->where('is_directory', false)->inRandomOrder()->first();

        return [
            'title' => $this->faker->word,
            'description' => $this->faker->sentence,
            'image' => $this->faker->randomElement($productImages),
            'on_sale' => true,
            'rating' => $this->faker->numberBetween(0, 5),
            'sold_count' => 0,
            'review_count' => 0,
            'price' => 0,
            'category_id' => $category ? $category->id : null,
        ];
    }
}
