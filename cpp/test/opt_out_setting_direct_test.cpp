// Generated direct-call tests for the opt_out_setting entity (unit mode;
// a mock system.fetch records calls). Mirrors the rust/go TestDirect.

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct OptOutSettingDirectSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value calls;
  bool live = false;
};

static OptOutSettingDirectSetup opt_out_setting_direct_setup(const Value& mockres) {
  Value calls = vlist();
  Value cshared = calls;

  vs::Injector mock_fetch = [cshared, mockres](vs::Injection&, const Value& args, const std::string&, const Value&) -> Value {
    Value url = vs::getelem(args, Value(int64_t(0)));
    Value init = vs::getelem(args, Value(int64_t(1)));
    cshared.as_list()->push_back(vmap({{"url", url}, {"init", init}}));
    Value data = is_nullish(mockres) ? vmap({{"id", Value("direct01")}}) : mockres;
    Value out = vmap();
    map_put(out, "status", Value(200));
    map_put(out, "statusText", Value("OK"));
    map_put(out, "headers", vmap());
    map_put(out, "json", json_thunk(data));
    return out;
  };

  Value opts = vmap({
    {"base", Value("http://localhost:8080")},
    {"system", vmap({{"fetch", Value(mock_fetch)}})}
  });
  auto client = std::make_shared<SmsapiSDK>(opts);

  OptOutSettingDirectSetup s;
  s.client = client;
  s.calls = calls;
  s.live = false;
  return s;
}

static void opt_out_setting_direct_load() {
  auto setup = opt_out_setting_direct_setup(vmap({{"id", Value("direct01")}}));
  auto sk = is_control_skipped("direct", "direct-load-opt_out_setting", "unit");
  if (sk.first) { std::cerr << "skip\n"; return; }
  auto client = setup.client;

  Value params = vmap();

  Value result = client->direct(vmap({
    {"path", Value("opt_outs/settings")},
    {"method", Value("GET")},
    {"params", params}
  }));

  ASSERT_EQ_VAL(getp(result, "ok"), Value(true), "expected ok true");
  ASSERT_EQ(Helpers::toInt(getp(result, "status")), 200, "expected status 200");
  ASSERT_TRUE(!getp(result, "data").is_undef(), "expected data to be non-nil");
  {
    Value data = getp(result, "data");
    if (data.is_map()) {
      ASSERT_EQ_VAL(getp(data, "id"), Value("direct01"), "expected data.id to be direct01");
    }
    ASSERT_EQ((int)setup.calls.as_list()->size(), 1, "expected 1 call");
    Value call = (*setup.calls.as_list())[0];
    ASSERT_EQ_VAL(getp(getp(call, "init"), "method"), Value("GET"), "expected method GET");
    std::string url = as_str(getp(call, "url"));
  }
}

int main() {
  T_RUN(opt_out_setting_direct_load);
  return sdktest::summary("opt_out_setting_direct_test");
}
