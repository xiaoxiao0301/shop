<?php

namespace App\Http\Controllers\Api;

use App\Exceptions\InvalidRequestException;
use App\Http\Requests\Api\PageRequest;
use App\Models\Coupon;
use Illuminate\Http\JsonResponse;

class CouponsController extends ApiBaseController
{
    /**
     * @OA\Get (
     *     path="/v1/coupons/{shopId}",
     *     tags={"优惠券"},
     *     summary="获取优惠券",
     *     description="获取指定店铺的优惠券",
     *     operationId="couponIndex",
     *     @OA\Parameter (
     *         name="shopId",
     *         in="path",
     *         description="店铺编号",
     *         required=true,
     *         @OA\Schema (
     *             type="integer",
     *             format="int64",
     *             minimum=1,
     *         )
     *     ),
     *     @OA\Parameter (
     *         name="page",
     *         in="query",
     *         description="页码",
     *         required=true,
     *         @OA\Schema (
     *             type="integer",
     *             format="int64",
     *             minimum=1,
     *             default=1,
     *         )
     *     ),
     *     @OA\Parameter (
     *         name="size",
     *         in="query",
     *         description="每页大小",
     *         required=true,
     *         @OA\Schema (
     *             type="integer",
     *             format="int64",
     *             minimum=1,
     *             default=20,
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="ok",
     *         @OA\MediaType (
     *             mediaType="application/json",
     *             @OA\Schema (
                       @OA\Property (
     *                    property="code",
     *                    type="integer",
     *                    description="业务状态吗, 非0表示失败",
     *                 ),
     *                 @OA\Property (
     *                    property="message",
     *                    type="string",
     *                    description="提示信息",
     *                ),
     *                @OA\Property (
     *                     property="data",
     *                     type="object",
     *                     description="请求结果",
     *                     @OA\Property (
     *                         property="coupons",
     *                         type="object",
     *                     ),
     *                    @OA\Property (
     *                        property="current_page",
     *                        type="integer",
     *                        description="当前请求页码",
     *                    ),
     *                    @OA\Property (
     *                        property="total_page",
     *                        type="integer",
     *                        description="总页码",
     *                    ),
     *                ),
     *             ),
     *         ),
     *     ),
     *
     *     @OA\Response(
     *         response=404,
     *         description="not found",
     *     ),
     * )
     * @param $shopId
     * @return JsonResponse
     */
    public function index($shopId, PageRequest $request): JsonResponse
    {
        $page = $request->input('page');
        $size = $request->input('size');
        $data = $this->couponService->getCouponsListByShopId($shopId);
        return $this->pageService->customPage($page, $size, $data, 'coupons');
    }


    /**
     * 用户领取优惠券
     *
     * @param $couponId
     * @return JsonResponse
     * @throws InvalidRequestException
     */
    public function collectCoupon($couponId): JsonResponse
    {
        return $this->userService->collectShopCoupon($couponId);
    }
}
