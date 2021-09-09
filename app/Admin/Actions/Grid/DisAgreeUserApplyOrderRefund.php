<?php

namespace App\Admin\Actions\Grid;

use Dcat\Admin\Actions\Response;
use Dcat\Admin\Grid\RowAction;
use Dcat\Admin\Traits\HasPermissions;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class DisAgreeUserApplyOrderRefund extends RowAction
{

    /**
     * @return string
     */
	protected $title = '拒绝';

    /**
     * 默认处理接口
     *
     * @param Request $request
     *
     * @return Response
     */
    public function handle(Request $request)
    {
//         dump($this->getKey());
    }

    /**
	 * @return string|array|void
	 */
	public function confirm()
	{
		//
	}

    /**
     * 设置按钮的HTML，这里我们需要附加上弹窗的HTML
     *
     * @return string|void
     */
    public function html()
    {
//        $this->setHtmlAttribute(['data-id' => $this->getKey(), 'class' => 'disagree btn btn-danger m-1']);
        $this->setHtmlAttribute(['data-id' => $this->getKey()]);
        // 按钮的html
       return parent::html();
    }

    /**
     * 设置HTML标签的属性
     *
     * @return void
     */
    protected function setupHtmlAttributes()
    {
        // 添加class
        $this->addHtmlClass('disagree btn btn-danger m-1');
        parent::setupHtmlAttributes();
    }

    public function script()
    {
        return <<<JS
    Dcat.ready(function() {
       $(".disagree").click(function() {
            order_id = $(this).data('id')
            url = 'refund'
            swal.fire({
                 title: '请输入拒绝退款理由',
                input: 'text',
                showCancelButton: true,
                inputValidator: (value) => {
                     if (!value) {
                        return '理由不能为空'
                     }
                    $.ajax({
                        url:  url,
                        type: 'post',
                        data: JSON.stringify({
                            agree: false,
                            reason: value,
                            order_id: order_id
                        }),
                        contentType: 'application/json',  // 请求的数据格式为 JSON
                        success: function (data) {  // 返回成功时会调用这个函数
                            if (data.status) {
                                 swal.fire({
                                    title: '操作成功',
                                    type: 'success'
                                 }).then(() => {
                                    window.location.reload()
                                 })
                            } else {
                                Dcat.error('服务器出现未知错误');
                            }

                        }
                    });
                }
            });

       });
    });
JS;

    }


    /**
     * @param Model|Authenticatable|HasPermissions|null $user
     *
     * @return bool
     */
    protected function authorize($user): bool
    {
        return true;
    }

    /**
     * @return array
     */
    protected function parameters()
    {
        return [];
    }
}
