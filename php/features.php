<?php
declare(strict_types=1);

// Smsapi SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/AuditFeature.php';
require_once __DIR__ . '/feature/CacheFeature.php';
require_once __DIR__ . '/feature/ClienttrackFeature.php';
require_once __DIR__ . '/feature/CostFeature.php';
require_once __DIR__ . '/feature/DebugFeature.php';
require_once __DIR__ . '/feature/IdempotencyFeature.php';
require_once __DIR__ . '/feature/LogFeature.php';
require_once __DIR__ . '/feature/MetricsFeature.php';
require_once __DIR__ . '/feature/NetsimFeature.php';
require_once __DIR__ . '/feature/PagingFeature.php';
require_once __DIR__ . '/feature/ProxyFeature.php';
require_once __DIR__ . '/feature/RatelimitFeature.php';
require_once __DIR__ . '/feature/RbacFeature.php';
require_once __DIR__ . '/feature/RetryFeature.php';
require_once __DIR__ . '/feature/SecretsFeature.php';
require_once __DIR__ . '/feature/StreamingFeature.php';
require_once __DIR__ . '/feature/TelemetryFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';
require_once __DIR__ . '/feature/TimeoutFeature.php';
require_once __DIR__ . '/feature/ValidateFeature.php';


class SmsapiFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new SmsapiBaseFeature();
            case "audit":
                return new SmsapiAuditFeature();
            case "cache":
                return new SmsapiCacheFeature();
            case "clienttrack":
                return new SmsapiClienttrackFeature();
            case "cost":
                return new SmsapiCostFeature();
            case "debug":
                return new SmsapiDebugFeature();
            case "idempotency":
                return new SmsapiIdempotencyFeature();
            case "log":
                return new SmsapiLogFeature();
            case "metrics":
                return new SmsapiMetricsFeature();
            case "netsim":
                return new SmsapiNetsimFeature();
            case "paging":
                return new SmsapiPagingFeature();
            case "proxy":
                return new SmsapiProxyFeature();
            case "ratelimit":
                return new SmsapiRatelimitFeature();
            case "rbac":
                return new SmsapiRbacFeature();
            case "retry":
                return new SmsapiRetryFeature();
            case "secrets":
                return new SmsapiSecretsFeature();
            case "streaming":
                return new SmsapiStreamingFeature();
            case "telemetry":
                return new SmsapiTelemetryFeature();
            case "test":
                return new SmsapiTestFeature();
            case "timeout":
                return new SmsapiTimeoutFeature();
            case "validate":
                return new SmsapiValidateFeature();
            default:
                return new SmsapiBaseFeature();
        }
    }

    /**
     * Does a generated feature class back this name? False for a name only
     * an options extend instance can supply (the station adopt path) - the
     * constructor uses this to skip make_feature for such names instead of
     * adding a stray BaseFeature.
     */
    public static function has_feature(string $name): bool
    {
        switch ($name) {
            case "base":
            case "audit":
            case "cache":
            case "clienttrack":
            case "cost":
            case "debug":
            case "idempotency":
            case "log":
            case "metrics":
            case "netsim":
            case "paging":
            case "proxy":
            case "ratelimit":
            case "rbac":
            case "retry":
            case "secrets":
            case "streaming":
            case "telemetry":
            case "test":
            case "timeout":
            case "validate":
                return true;
            default:
                return false;
        }
    }
}
