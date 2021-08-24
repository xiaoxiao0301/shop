<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\UserAddress;
use Faker\Generator as Faker;

$factory->define(UserAddress::class, function (Faker $faker) {
    $addresses = [
        ["北京市", "市辖区", "东城区"],
        ["北京市", "市辖区", "丰台区"],
        ["北京市", "市辖区", "朝阳区"],
        ["河北省", "石家庄市", "长安区"],
        ["江苏省", "南京市", "浦口区"],
        ["江苏省", "苏州市", "相城区"],
        ["广东省", "深圳市", "福田区"],
        ["陕西省", "宝鸡市", "渭滨区"],
        ["陕西省", "西安市", "雁塔区"],
    ];
    $address   = $faker->randomElement($addresses);
    $user = \App\Models\User::find(2);
    return [
        'user_id' => $user->user_id,
        'province' => $address[0],
        'city' => $address[1],
        'district' => $address[2],
        'address' => sprintf("第%d街道%d号", $faker->randomNumber(2), $faker->randomNumber(3)),
        'zip' => $faker->postcode,
        'contact_name' => $faker->name,
        'contact_phone' => $faker->phoneNumber,
    ];
});
