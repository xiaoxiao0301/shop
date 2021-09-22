<?php

namespace App\Exceptions;

use App\Dict\ResponseJsonData;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class Handler extends ExceptionHandler
{
    /**
     * A list of the exception types that are not reported.
     *
     * @var array
     */
    protected $dontReport = [
        InvalidRequestException::class,
    ];

    /**
     * A list of the inputs that are never flashed for validation exceptions.
     *
     * @var array
     */
    protected $dontFlash = [
        'password',
        'password_confirmation',
    ];

    /**
     * Register the exception handling callbacks for the application.
     *
     * @return void
     */
    public function register()
    {
        $this->renderable(function (AuthenticationException $exception, $request) {
            return ResponseJsonData::responseUnAuthorization('请重新登陆');
        });

        $this->renderable(function (NotFoundHttpException $exception, $request) {
            return ResponseJsonData::responseNotFound('数据不存在');
        });

        $this->renderable(function (AccessDeniedHttpException $exception, $request) {
           return ResponseJsonData::responseUnAuthorization($exception->getMessage());
        });
    }
}
