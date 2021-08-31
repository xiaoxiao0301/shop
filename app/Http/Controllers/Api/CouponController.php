<?php

namespace App\Http\Controllers\Api;

use App\dict\Codes;
use App\Exceptions\CouponCodeUnavailableException;
use App\Http\Requests\Api\CouponRequest;
use Illuminate\Http\JsonResponse;

class CouponController extends BaseController
{

    /**
     * 检查优惠券码状态
     *
     * @param CouponRequest $request
     * @return JsonResponse
     * @throws CouponCodeUnavailableException
     */
    public function checkCouponCode(CouponRequest $request): JsonResponse
    {
        $code = $request->input('code');
        $user = $this->userService->getCurrentUserInfo();
        $result = $this->couponCodeService->checkCouponCodeIsAvailable($user, $code);
        return $this->responseData(Codes::CODE_SUCCESS, $result->toArray(), Codes::STATUS_CODE_OK);
    }

}
