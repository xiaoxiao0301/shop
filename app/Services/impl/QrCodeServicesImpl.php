<?php

namespace App\Services\impl;

use Endroid\QrCode\QrCode;
use Endroid\QrCode\Writer\PngWriter;

class QrCodeServicesImpl
{

    /**
     * 生成支付二维码
     *
     * @param $url
     * @throws \Exception
     */
    public static function generateOrCodePngFromUrl($url)
    {
        $writer = new PngWriter();
        $qrCode = new QrCode($url);
        $qrCode->setSize(200);
        $result = $writer->write($qrCode);
        return response($result->getString(), 200, ['Content-Type' => $result->getMimeType()]);
    }
}
