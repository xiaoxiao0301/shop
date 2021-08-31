<?php

namespace App\Exceptions;

use App\dict\Codes;
use Exception;
use Throwable;

class CouponCodeUnavailableException extends Exception
{
    protected $codes;

    public function __construct($codes, $message = "", $code = 0, Throwable $previous = null)
    {
        parent::__construct($message, $code, $previous);
        $this->codes = $codes;
    }

    public function render()
    {
        return response()->json([
            "code" => $this->codes,
            "message" => Codes::getMessageByCode($this->codes),
            "data" => []
        ])->setStatusCode($this->code);
    }
}
