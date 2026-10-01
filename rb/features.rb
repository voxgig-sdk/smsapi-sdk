# Smsapi SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/audit_feature'
require_relative 'feature/cache_feature'
require_relative 'feature/clienttrack_feature'
require_relative 'feature/cost_feature'
require_relative 'feature/debug_feature'
require_relative 'feature/idempotency_feature'
require_relative 'feature/log_feature'
require_relative 'feature/metrics_feature'
require_relative 'feature/netsim_feature'
require_relative 'feature/paging_feature'
require_relative 'feature/proxy_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/rbac_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/secrets_feature'
require_relative 'feature/streaming_feature'
require_relative 'feature/telemetry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'
require_relative 'feature/validate_feature'


module SmsapiFeatures
  def self.make_feature(name)
    case name
    when "base"
      SmsapiBaseFeature.new
    when "audit"
      SmsapiAuditFeature.new
    when "cache"
      SmsapiCacheFeature.new
    when "clienttrack"
      SmsapiClienttrackFeature.new
    when "cost"
      SmsapiCostFeature.new
    when "debug"
      SmsapiDebugFeature.new
    when "idempotency"
      SmsapiIdempotencyFeature.new
    when "log"
      SmsapiLogFeature.new
    when "metrics"
      SmsapiMetricsFeature.new
    when "netsim"
      SmsapiNetsimFeature.new
    when "paging"
      SmsapiPagingFeature.new
    when "proxy"
      SmsapiProxyFeature.new
    when "ratelimit"
      SmsapiRatelimitFeature.new
    when "rbac"
      SmsapiRbacFeature.new
    when "retry"
      SmsapiRetryFeature.new
    when "secrets"
      SmsapiSecretsFeature.new
    when "streaming"
      SmsapiStreamingFeature.new
    when "telemetry"
      SmsapiTelemetryFeature.new
    when "test"
      SmsapiTestFeature.new
    when "timeout"
      SmsapiTimeoutFeature.new
    when "validate"
      SmsapiValidateFeature.new
    else
      SmsapiBaseFeature.new
    end
  end
end
