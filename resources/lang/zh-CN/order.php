<?php 
return [
    'labels' => [
        'Order' => 'Order',
        'order' => 'Order',
    ],
    'fields' => [
        'order_no' => '订单流水号',
        'user_id' => '下单的用户ID',
        'address' => 'JSON格式的收货地址',
        'total_amount' => '订单总金额',
        'remark' => '订单备注',
        'paid_at' => '支付时间',
        'payment_method' => '支付方式',
        'payment_no' => '支付平台订单号',
        'refund_status' => '退款状态',
        'refund_no' => '退款单号',
        'closed' => '订单是否已关闭',
        'reviewed' => '订单是否已评价',
        'ship_status' => '物流状态',
        'ship_data' => '物流数据',
        'extra' => '其他额外的数据',
    ],
    'options' => [
    ],
];
