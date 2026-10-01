<?php
declare(strict_types=1);

// Smsapi SDK utility: result_headers

class SmsapiResultHeaders
{
    public static function call(SmsapiContext $ctx): ?SmsapiResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
