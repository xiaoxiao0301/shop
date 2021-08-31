<?php

namespace App\Exceptions;

use App\dict\Codes;
use Exception;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class Handler extends ExceptionHandler
{
    /**
     * A list of the exception types that are not reported.
     *
     * @var array
     */
    protected $dontReport = [
        InvalidRequestException::class,
        CouponCodeUnavailableException::class,
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
     * Report or log an exception.
     *
     * @param  \Exception  $exception
     * @return void
     *
     * @throws \Exception
     */
    public function report(Exception $exception)
    {
        parent::report($exception);
    }

    /**
     * Render an exception into an HTTP response.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Exception  $exception
     * @return \Symfony\Component\HttpFoundation\Response
     *
     * @throws \Exception
     */
    public function render($request, Exception $exception)
    {
        if ($exception instanceof AuthenticationException) {
            return response()->json([
                "code" => Codes::CODE_TOKEN_EXPIRE,
                "message" => Codes::getMessageByCode(Codes::CODE_TOKEN_EXPIRE),
                "data" => []
            ])->setStatusCode(Codes::STATUS_CODE_NOT_AUTHORIZATION);
        }

        if ($exception instanceof ModelNotFoundException) {
            return response()->json([
                "code" => Codes::CODE_DATA_NOT_FOUND,
                "message" => Codes::getMessageByCode(Codes::CODE_DATA_NOT_FOUND),
                "data" => []
            ])->setStatusCode(Codes::STATUS_CODE_NOT_FOUND);
        }

        return parent::render($request, $exception);
    }
}
