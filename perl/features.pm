# Smsapi SDK feature factory

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/feature/base_feature.pm"));
require(Cwd::abs_path("$__dir/feature/audit_feature.pm"));
require(Cwd::abs_path("$__dir/feature/cache_feature.pm"));
require(Cwd::abs_path("$__dir/feature/clienttrack_feature.pm"));
require(Cwd::abs_path("$__dir/feature/cost_feature.pm"));
require(Cwd::abs_path("$__dir/feature/debug_feature.pm"));
require(Cwd::abs_path("$__dir/feature/idempotency_feature.pm"));
require(Cwd::abs_path("$__dir/feature/log_feature.pm"));
require(Cwd::abs_path("$__dir/feature/metrics_feature.pm"));
require(Cwd::abs_path("$__dir/feature/netsim_feature.pm"));
require(Cwd::abs_path("$__dir/feature/paging_feature.pm"));
require(Cwd::abs_path("$__dir/feature/proxy_feature.pm"));
require(Cwd::abs_path("$__dir/feature/ratelimit_feature.pm"));
require(Cwd::abs_path("$__dir/feature/rbac_feature.pm"));
require(Cwd::abs_path("$__dir/feature/retry_feature.pm"));
require(Cwd::abs_path("$__dir/feature/secrets_feature.pm"));
require(Cwd::abs_path("$__dir/feature/streaming_feature.pm"));
require(Cwd::abs_path("$__dir/feature/telemetry_feature.pm"));
require(Cwd::abs_path("$__dir/feature/test_feature.pm"));
require(Cwd::abs_path("$__dir/feature/timeout_feature.pm"));
require(Cwd::abs_path("$__dir/feature/validate_feature.pm"));

package SmsapiFeatures;

sub make_feature {
  my ($name) = @_;
  $name = '' unless defined $name;
  return SmsapiBaseFeature->new if 'base' eq $name;
  return SmsapiAuditFeature->new if 'audit' eq $name;
  return SmsapiCacheFeature->new if 'cache' eq $name;
  return SmsapiClienttrackFeature->new if 'clienttrack' eq $name;
  return SmsapiCostFeature->new if 'cost' eq $name;
  return SmsapiDebugFeature->new if 'debug' eq $name;
  return SmsapiIdempotencyFeature->new if 'idempotency' eq $name;
  return SmsapiLogFeature->new if 'log' eq $name;
  return SmsapiMetricsFeature->new if 'metrics' eq $name;
  return SmsapiNetsimFeature->new if 'netsim' eq $name;
  return SmsapiPagingFeature->new if 'paging' eq $name;
  return SmsapiProxyFeature->new if 'proxy' eq $name;
  return SmsapiRatelimitFeature->new if 'ratelimit' eq $name;
  return SmsapiRbacFeature->new if 'rbac' eq $name;
  return SmsapiRetryFeature->new if 'retry' eq $name;
  return SmsapiSecretsFeature->new if 'secrets' eq $name;
  return SmsapiStreamingFeature->new if 'streaming' eq $name;
  return SmsapiTelemetryFeature->new if 'telemetry' eq $name;
  return SmsapiTestFeature->new if 'test' eq $name;
  return SmsapiTimeoutFeature->new if 'timeout' eq $name;
  return SmsapiValidateFeature->new if 'validate' eq $name;
  return SmsapiBaseFeature->new;
}

1;
