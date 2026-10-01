// Generated direct-call tests for the shipment_country_volume entity (unit mode;
// a mock system.fetch records calls). Mirrors the rust/go TestDirect.

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct ShipmentCountryVolumeDirectSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value calls;
  bool live = false;
};

static ShipmentCountryVolumeDirectSetup shipment_country_volume_direct_setup(const Value& mockres) {
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

  ShipmentCountryVolumeDirectSetup s;
  s.client = client;
  s.calls = calls;
  s.live = false;
  return s;
}

static void shipment_country_volume_direct_list() {
  auto setup = shipment_country_volume_direct_setup(vlist({
    vmap({{"id", Value("direct01")}}),
    vmap({{"id", Value("direct02")}})
  }));
  auto sk = is_control_skipped("direct", "direct-list-shipment_country_volume", "unit");
  if (sk.first) { std::cerr << "skip\n"; return; }
  auto client = setup.client;

  Value params = vmap();

  Value result = client->direct(vmap({
    {"path", Value("shipment/country_volumes")},
    {"method", Value("GET")},
    {"params", params}
  }));

  ASSERT_EQ_VAL(getp(result, "ok"), Value(true), "expected ok true");
  ASSERT_EQ(Helpers::toInt(getp(result, "status")), 200, "expected status 200");
  Value data = getp(result, "data");
  ASSERT_TRUE(data.is_list(), "expected data to be an array");
  ASSERT_EQ((int)Struct::size(data), 2, "expected 2 items");
  ASSERT_EQ((int)setup.calls.as_list()->size(), 1, "expected 1 call");
}

int main() {
  T_RUN(shipment_country_volume_direct_list);
  return sdktest::summary("shipment_country_volume_direct_test");
}
