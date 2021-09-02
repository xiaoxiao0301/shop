<?php

namespace Database\Factories;

use App\Models\ProductSku;
use Illuminate\Database\Eloquent\Factories\Factory;

class ProductSkuFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = ProductSku::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'title' => $this->faker->word,
            'description' => $this->faker->sentence,
            'price' => $this->faker->randomNumber(4),
            'stock' => $this->faker->randomNumber(5),
        ];
    }
}
