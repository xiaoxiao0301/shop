<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\User;
use Faker\Generator as Faker;
use Illuminate\Support\Str;

/*
|--------------------------------------------------------------------------
| Model Factories
|--------------------------------------------------------------------------
|
| This directory should contain each of the model factory definitions for
| your application. Factories provide a convenient way to generate new
| model instances for testing / seeding your application's database.
|
*/

$factory->define(User::class, function (Faker $faker) {

    $phoneNumbers = [
        '131201011100',
        '135201011100',
        '138201011100',
        '168201011100',
        '157201011100',
        '147201011100',
        '136201011100',
        '145201011100',
        '186201011100',
    ];

    return [
        'name' => $faker->name,
        'phone' => $faker->randomElement($phoneNumbers),
        'email' => $faker->unique()->safeEmail,
        'email_verified_at' => now(),
        'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', // password
        'remember_token' => Str::random(10),
        'created_at' => $faker->date. ' ' . $faker->time,
        'updated_at' => $faker->date. ' ' . $faker->time,
    ];
});
