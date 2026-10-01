// Generated basic-flow test for the smstemplate entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct SmstemplateSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static SmstemplateSetup smstemplate_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/smstemplate/SmstemplateTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("smstemplate01"), Value("smstemplate02"), Value("smstemplate03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_SMSTEMPLATE_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_SMSTEMPLATE_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  SmstemplateSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void smstemplate_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->smstemplate();
  ASSERT_EQ(ent->getName(), std::string("smstemplate"), "entity name");
}


static void smstemplate_entity_basic() {
  auto setup = smstemplate_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{}) {
    auto sk = is_control_skipped("entityOp", std::string("smstemplate.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;

  // Bootstrap entity data from existing test data (no create step in flow).
  // Declare _data at FUNCTION scope (later load/update steps reference it);
  // only _data_raw was declared, so the block-local assignment left _data
  // undeclared ("was not declared in this scope").
  Value smstemplate_ref01_data_raw = Helpers::toMapAny(Struct::getpath(setup.data, {"existing", "smstemplate"}));
  Value smstemplate_ref01_data = vmap();
  {
    std::vector<Value> its = Struct::items(smstemplate_ref01_data_raw);
    smstemplate_ref01_data = its.empty() ? vmap() : Helpers::toMapAny(pair_val(its[0]));
    if (!smstemplate_ref01_data.is_map()) smstemplate_ref01_data = vmap();
  }
}

int main() {
  T_RUN(smstemplate_entity_instance);
  T_RUN(smstemplate_entity_basic);
  return sdktest::summary("smstemplate_entity_test");
}
