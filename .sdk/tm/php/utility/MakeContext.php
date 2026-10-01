<?php
declare(strict_types=1);

// Smsapi SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class SmsapiMakeContext
{
    public static function call(array $ctxmap, ?SmsapiContext $basectx): SmsapiContext
    {
        return new SmsapiContext($ctxmap, $basectx);
    }
}
