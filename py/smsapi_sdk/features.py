# Smsapi SDK feature factory

from smsapi_sdk.feature.base_feature import SmsapiBaseFeature
from smsapi_sdk.feature.audit_feature import SmsapiAuditFeature
from smsapi_sdk.feature.cache_feature import SmsapiCacheFeature
from smsapi_sdk.feature.clienttrack_feature import SmsapiClienttrackFeature
from smsapi_sdk.feature.cost_feature import SmsapiCostFeature
from smsapi_sdk.feature.debug_feature import SmsapiDebugFeature
from smsapi_sdk.feature.idempotency_feature import SmsapiIdempotencyFeature
from smsapi_sdk.feature.log_feature import SmsapiLogFeature
from smsapi_sdk.feature.metrics_feature import SmsapiMetricsFeature
from smsapi_sdk.feature.netsim_feature import SmsapiNetsimFeature
from smsapi_sdk.feature.paging_feature import SmsapiPagingFeature
from smsapi_sdk.feature.proxy_feature import SmsapiProxyFeature
from smsapi_sdk.feature.ratelimit_feature import SmsapiRatelimitFeature
from smsapi_sdk.feature.rbac_feature import SmsapiRbacFeature
from smsapi_sdk.feature.retry_feature import SmsapiRetryFeature
from smsapi_sdk.feature.secrets_feature import SmsapiSecretsFeature
from smsapi_sdk.feature.streaming_feature import SmsapiStreamingFeature
from smsapi_sdk.feature.telemetry_feature import SmsapiTelemetryFeature
from smsapi_sdk.feature.test_feature import SmsapiTestFeature
from smsapi_sdk.feature.timeout_feature import SmsapiTimeoutFeature
from smsapi_sdk.feature.validate_feature import SmsapiValidateFeature


_FEATURES = {
    "base": lambda: SmsapiBaseFeature(),
    "audit": lambda: SmsapiAuditFeature(),
    "cache": lambda: SmsapiCacheFeature(),
    "clienttrack": lambda: SmsapiClienttrackFeature(),
    "cost": lambda: SmsapiCostFeature(),
    "debug": lambda: SmsapiDebugFeature(),
    "idempotency": lambda: SmsapiIdempotencyFeature(),
    "log": lambda: SmsapiLogFeature(),
    "metrics": lambda: SmsapiMetricsFeature(),
    "netsim": lambda: SmsapiNetsimFeature(),
    "paging": lambda: SmsapiPagingFeature(),
    "proxy": lambda: SmsapiProxyFeature(),
    "ratelimit": lambda: SmsapiRatelimitFeature(),
    "rbac": lambda: SmsapiRbacFeature(),
    "retry": lambda: SmsapiRetryFeature(),
    "secrets": lambda: SmsapiSecretsFeature(),
    "streaming": lambda: SmsapiStreamingFeature(),
    "telemetry": lambda: SmsapiTelemetryFeature(),
    "test": lambda: SmsapiTestFeature(),
    "timeout": lambda: SmsapiTimeoutFeature(),
    "validate": lambda: SmsapiValidateFeature(),
}


def _make_feature(name):
    factory = _FEATURES.get(name)
    if factory is not None:
        return factory()
    return _FEATURES["base"]()


# True when this SDK was generated with the named feature class - the
# constructor's tolerance for extend-carried features reads this (an
# active name with no generated class must not become a BaseFeature
# stray when an extend instance carries it).
def _has_feature(name):
    return name in _FEATURES
