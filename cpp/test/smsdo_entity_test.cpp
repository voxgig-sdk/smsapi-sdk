// Generated basic-flow test for the smsdo entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct SmsdoSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static SmsdoSetup smsdo_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/smsdo/SmsdoTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("smsdo01"), Value("smsdo02"), Value("smsdo03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_SMSDO_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_SMSDO_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  SmsdoSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void smsdo_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->smsdo();
  ASSERT_EQ(ent->getName(), std::string("smsdo"), "entity name");
}


static bool smsdo_has_feature(const std::string& name) {
  Value fm = Helpers::toMapAny(getp(sharedConfig(), "feature"));
  return fm.is_map() && !getp(fm, name).is_undef();
}

static void smsdo_entity_validate() {
  if (!smsdo_has_feature("validate")) {
    std::cerr << "skip: feature not present in this SDK: validate\n";
    return;
  }
  auto vsdk = SmsapiSDK::testSDK(Value::undef(), vmap({{"feature",
      vmap({{"validate", vmap({{"active", Value(true)}})}})}}));
  std::string code;
  try {
    vsdk->smsdo()->create(vmap({{"allow_duplicates", Value("x")}}), Value::undef());
  } catch (const SdkErrorPtr& err) {
    code = err->code;
  }
  ASSERT_EQ(code, std::string("validate_failed"), "an invalid request fails with validate_failed");
}

static void smsdo_entity_basic() {
  auto setup = smsdo_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create"}) {
    auto sk = is_control_skipped("entityOp", std::string("smsdo.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto smsdo_ref01_ent = client->smsdo();
  Value smsdo_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "smsdo"}), "smsdo_ref01"));
  if (!smsdo_ref01_data.is_map()) smsdo_ref01_data = vmap();
  {
    Value smsdo_ref01_data_result = smsdo_ref01_ent->create(Struct::clone(smsdo_ref01_data), Value::undef())->data();
    smsdo_ref01_data = Helpers::toMapAny(smsdo_ref01_data_result);
    if (!smsdo_ref01_data.is_map()) smsdo_ref01_data = vmap();
    ASSERT_TRUE(smsdo_ref01_data.is_map(), "expected create result to be a map");
  }

}

int main() {
  T_RUN(smsdo_entity_instance);
  T_RUN(smsdo_entity_validate);
  T_RUN(smsdo_entity_basic);
  return sdktest::summary("smsdo_entity_test");
}
