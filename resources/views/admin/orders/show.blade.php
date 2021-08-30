<div class="box box-info">
    <div class="box-header with-border">
        <h3 class="box-title">订单流水号：{{ $order->order_no }}</h3>
        <div class="box-tools">
            <div class="btn-group pull-right" style="margin-right: 10px">
                <a href="{{ route('dcat.admin.orders.index') }}" class="btn btn-sm btn-default"><i class="fa fa-list"></i> 列表</a>
            </div>
        </div>
    </div>
    <div class="box-body">
        <table class="table table-bordered">
            <tbody>
            <tr>
                <td>买家：</td>
                <td>{{ $order->user->name }} |{{ $order->user->phone }}</td>
                <td>支付时间：</td>
                <td>{{ $order->paid_at->format('Y-m-d H:i:s') }}</td>
            </tr>
            <tr>
                <td>支付方式：</td>
                <td>{{ $order->payment_method }}</td>
                <td>支付渠道单号：</td>
                <td>{{ $order->payment_no }}</td>
            </tr>
            <tr>
                <td>收货地址</td>
                <td colspan="3">{{ $order->address['address'] }} {{ $order->address['zip'] }} {{ $order->address['contact_name'] }} {{ $order->address['contact_phone'] }}</td>
            </tr>
            <tr>
                <td rowspan="{{ $order->items->count() + 1 }}">商品列表</td>
                <td>商品名称</td>
                <td>单价</td>
                <td>数量</td>
            </tr>
            @foreach($order->items as $item)
                <tr>
                    <td>{{ $item->product->title }} {{ $item->productSku->title }}</td>
                    <td>￥{{ $item->price }}</td>
                    <td>{{ $item->amount }}</td>
                </tr>
            @endforeach
            <tr>
                <td>订单金额：</td>
                <td>￥{{ $order->total_amount }}</td>
                <!-- 这里也新增了一个发货状态 -->
                <td>发货状态：</td>
                <td>{{ \App\dict\OrderDict::$shipStatusMap[$order->ship_status] }}</td>
            </tr>
            @if($order->ship_status === \App\dict\OrderDict::SHIP_STATUS_PENDING)
                <tr>
                    <td colspan="4">
                        <form action="{{ route('dcat.admin.order.ship', $order->id) }}" method="post" class="form-inline">
                            @csrf
                            <div class="form-group {{ $errors->has('express_company') ? 'has-error' : '' }}">
                                <label for="express_company" class="control-label">物流公司</label>
                                <input type="text" id="express_company" name="express_company" value="" class="form-control" placeholder="输入物流公司">
                                @if($errors->has('express_company'))
                                    @foreach($errors->get('express_company') as $msg)
                                        <span class="help-block">{{ $msg }}</span>
                                    @endforeach
                                @endif
                            </div>
                            <div class="form-group {{ $errors->has('express_no') ? 'has-error' : '' }}">
                                <label for="express_no" class="control-label">物流单号</label>
                                <input type="text" id="express_no" name="express_no" value="" class="form-control" placeholder="输入物流单号">
                                @if($errors->has('express_no'))
                                    @foreach($errors->get('express_no') as $msg)
                                        <span class="help-block">{{ $msg }}</span>
                                    @endforeach
                                @endif
                            </div>
                            <button type="submit" class="btn btn-success" id="ship-btn">发货</button>
                        </form>
                    </td>
                </tr>
            @else
                <!-- 否则展示物流公司和物流单号 -->
                <tr>
                    <td>物流公司：</td>
                    <td>{{ $order->ship_data['express_company'] }}</td>
                    <td>物流单号：</td>
                    <td>{{ $order->ship_data['express_no'] }}</td>
                </tr>
            @endif
            @if($order->refund_status !== \App\dict\OrderDict::REFUND_STATUS_PENDING)
                <tr>
                    <td>退款状态：</td>
                    <td colspan="2">{{ \App\dict\OrderDict::$refundStatusMap[$order->refund_status] }}，理由：{{ $order->extra['refund_reason'] }}</td>
                    <td>
                        <!-- 如果订单退款状态是已申请，则展示处理按钮 -->
                        @if($order->refund_status === \App\dict\OrderDict::REFUND_STATUS_APPLIED)
                            <button class="btn btn-sm btn-success" id="btn-refund-agree">同意</button>
                            <button class="btn btn-sm btn-danger" id="btn-refund-disagree">不同意</button>
                        @endif
                    </td>
                </tr>
            @endif
            </tbody>
        </table>
    </div>
</div>

<script>
    Dcat.ready(function () {
        $("#btn-refund-disagree").click(function () {
            swal.fire({
                title: '请输入拒绝退款理由',
                input: 'text',
                showCancelButton: true,
                inputValidator: (value) => {
                    if (!value) {
                        return '理由不能为空'
                    }
                    $.ajax({
                        url: '{{ route('dcat.admin.order.refund', $order->id) }}',
                        type: 'post',
                        data: JSON.stringify({
                            agree: false,
                            reason: value,
                        }),
                        contentType: 'application/json',  // 请求的数据格式为 JSON
                        success: function (data) {  // 返回成功时会调用这个函数
                            swal.fire({
                                title: '操作成功',
                                type: 'success',
                            }).then(() => {
                                window.location.reload()
                            })
                        },
                    });
                }
            })
        });
    })

</script>
