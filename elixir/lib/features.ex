# Smsapi SDK feature factory

defmodule Smsapi.Features do
  def make_feature(name) do
    case name do
      "audit" -> Smsapi.Feature.Audit.new()
      "cache" -> Smsapi.Feature.Cache.new()
      "clienttrack" -> Smsapi.Feature.Clienttrack.new()
      "cost" -> Smsapi.Feature.Cost.new()
      "debug" -> Smsapi.Feature.Debug.new()
      "idempotency" -> Smsapi.Feature.Idempotency.new()
      "log" -> Smsapi.Feature.Log.new()
      "metrics" -> Smsapi.Feature.Metrics.new()
      "netsim" -> Smsapi.Feature.Netsim.new()
      "paging" -> Smsapi.Feature.Paging.new()
      "proxy" -> Smsapi.Feature.Proxy.new()
      "ratelimit" -> Smsapi.Feature.Ratelimit.new()
      "rbac" -> Smsapi.Feature.Rbac.new()
      "retry" -> Smsapi.Feature.Retry.new()
      "secrets" -> Smsapi.Feature.Secrets.new()
      "streaming" -> Smsapi.Feature.Streaming.new()
      "telemetry" -> Smsapi.Feature.Telemetry.new()
      "test" -> Smsapi.Feature.Test.new()
      "timeout" -> Smsapi.Feature.Timeout.new()
      "validate" -> Smsapi.Feature.Validate.new()
      _ -> Smsapi.Feature.new()
    end
  end
end
