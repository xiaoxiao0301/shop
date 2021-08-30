<?php

namespace App\Services\impl;

use App\Exceptions\InvalidRequestException;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\ProductSku;
use App\Models\User;
use App\Models\UserAddress;
use App\Services\OrderServicesIf;
use Carbon\Carbon;
use Endroid\QrCode\QrCode;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\Routing\ResponseFactory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Throwable;

class OrderServiceImpl implements OrderServicesIf
{

    /**
     * 创建订单
     *
     * @param $user
     * @param $data
     * @return mixed
     * @throws Throwable
     */
    public function createOrder($user, $data)
    {
        // transaction 事务中有异常会rollback
        $order = DB::transaction(function () use ($user, $data) {
            // 更新当前地址的最后使用时间
            $address = UserAddress::find($data['address_id']);
            $address->update(['last_used_at' => Carbon::now()]);

            // 创建订单
            $order = new Order([
                'address' => [
                    'address' => $address->full_address,
                    'zip' => $address->zip,
                    'contact_name' => $address->contact_name,
                    'contact_phone' => $address->contact_phone,
                ],
                'remark' => $data['remark'],
                'total_amount' => 0,
            ]);
            // 订单关联用户
            $order->user()->associate($user);
            $order->save();

            $totalAmount = 0;
            // 遍历用户提交的sku
            foreach ($data['items'] as $item) {
                /** @var ProductSku $sku */
                $sku = ProductSku::find($item['product_sku_id']);
                // 创建订单item
                /** @var OrderItem $orderItem */
                $orderItem = $order->items()->make([
                    'amount' => $item['amount'],
                    'price' => $sku->price,
                ]);
                $orderItem->product()->associate($sku->product_id);
                $orderItem->productSku()->associate($sku);
                $orderItem->save();
                $totalAmount += $sku->price * $item['amount'];
                if ($sku->decreaseStock($item['amount']) <= 0) {
                    throw new InvalidRequestException("该商品库存不足");
                }
            }

            // 更新订单总额
            $order->total_amount = $totalAmount;
            $order->save();

            // 从购物车移除下单商品
            $skuIds = collect($data['items'])->pluck('product_sku_id');
            /** @var User $user */
            $user->carItems()->whereIn('product_sku_id', $skuIds)->delete();

            return $order;
        });

        return $order;

    }

    /**
     * 获取订单列表
     *
     * @param $user
     * @return Builder[]|Collection
     */
    public function orderListsByUser($user)
    {
        return Order::query()->with(['items.product', 'items.productSku'])
            ->where('user_id', $user->user_id)
            ->orderBy('created_at', 'desc')
            ->get();
    }


    /**
     * 支付订单
     *
     * @param $order
     * @return mixed
     * @throws InvalidRequestException
     */
    public function orderPaymentByAli($order)
    {
        // 订单已支付或者已关闭
        if ($order->paid_at || $order->closed) {
            throw new InvalidRequestException('订单状态不正确');
        }
        // 调用支付宝的网页支付
        return app('alipay')->web([
            'out_trade_no' => $order->no, // 订单编号，需保证在商户端不重复
            'total_amount' => $order->total_amount, // 订单金额，单位元，支持小数点后两位
            'subject'      => '支付 Laravel Shop 的订单：'.$order->no, // 订单标题
        ]);
    }


    /**
     * 微信支付
     *
     * @param $order
     * @return Application|ResponseFactory|Response
     * @throws InvalidRequestException
     */
    public function orderPaymentByWechat($order)
    {
        // 校验订单状态
        if ($order->paid_at || $order->closed) {
            throw new InvalidRequestException('订单状态不正确');
        }
        // scan 方法为拉起微信扫码支付
        $wechatOrder =  app('wechat_pay')->scan([
            'out_trade_no' => $order->no,  // 商户订单流水号
            'total_fee' => $order->total_amount * 100, // 微信支付的金额单位是分。
            'body'      => '支付 Laravel Shop 的订单：'.$order->no, // 订单描述
        ]);

        // 把要转换的字符串作为 QrCode 的构造函数参数
        $qrCode = new QrCode($wechatOrder->code_url);
        // 将生成的二维码图片数据以字符串形式输出，并带上相应的响应类型
        return response($qrCode->writeString(), 200, ['Content-Type' => $qrCode->getContentType()]);
    }
}
