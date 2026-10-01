<?php
declare(strict_types=1);

// Smsapi SDK utility: result_body

class SmsapiResultBody
{
    public static function call(SmsapiContext $ctx): ?SmsapiResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
