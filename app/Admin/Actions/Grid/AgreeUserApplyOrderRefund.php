<?php

namespace App\Admin\Actions\Grid;

use Dcat\Admin\Actions\Response;
use Dcat\Admin\Grid\RowAction;
use Dcat\Admin\Traits\HasPermissions;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class AgreeUserApplyOrderRefund extends RowAction
{
    /**
     * @return string
     */
	protected $title = '同意';

    /**
     * Handle the action request.
     *
     * @param Request $request
     *
     * @return Response
     */
    public function handle(Request $request)
    {
        // dump($this->getKey());

//       dd($request->all());
    }

    /**
	 * @return string|array|void
	 */
	public function confirm()
	{
//		return '确认退款码?';
	}

    /**
     * 设置HTML标签的属性
     *
     * @return void
     */
    protected function setupHtmlAttributes()
    {
        // 添加class
        $this->addHtmlClass('agree btn btn-success p-3');
        // 保存弹窗的ID
//        $this->setHtmlAttribute('data-target', '#'.$this->modalId);

        parent::setupHtmlAttributes();
    }

    public function html()
    {
        $this->setHtmlAttribute(['data-id' => $this->getKey()]);
        return parent::html();
    }


    public function script()
    {
        return <<<JS
    Dcat.ready(function() {
       $(".agree").click(function() {
            order_id = $(this).data('id')
            url = 'refund'
            $.ajax({
                url:  url,
                type: 'post',
                data: JSON.stringify({
                    agree: true,
                    order_id: order_id
                }),
                contentType: 'application/json',
                success: function (data) {
                   if (data.status) {
                         swal.fire({
                            title: '操作成功',
                            type: 'success'
                         }).then(() => {
                            window.location.reload()
                         })
                    } else {
                       swal.fire({
                            title: data.data.message,
                            type: 'error'
                         }).then(() => {
                            window.location.reload()
                         })
                    }
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
