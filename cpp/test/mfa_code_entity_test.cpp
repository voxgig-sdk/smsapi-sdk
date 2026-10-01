// Generated basic-flow test for the mfa_code entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct MfaCodeSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static MfaCodeSetup mfa_code_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/mfa_code/MfaCodeTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("mfa_code01"), Value("mfa_code02"), Value("mfa_code03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_MFA_CODE_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_MFA_CODE_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  MfaCodeSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void mfa_code_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->mfa_code();
  ASSERT_EQ(ent->getName(), std::string("mfa_code"), "entity name");
}


static void mfa_code_entity_basic() {
  auto setup = mfa_code_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create"}) {
    auto sk = is_control_skipped("entityOp", std::string("mfa_code.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto mfa_code_ref01_ent = client->mfa_code();
  Value mfa_code_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "mfa_code"}), "mfa_code_ref01"));
  if (!mfa_code_ref01_data.is_map()) mfa_code_ref01_data = vmap();
  {
    Value mfa_code_ref01_data_result = mfa_code_ref01_ent->create(Struct::clone(mfa_code_ref01_data), Value::undef())->data();
    mfa_code_ref01_data = Helpers::toMapAny(mfa_code_ref01_data_result);
    if (!mfa_code_ref01_data.is_map()) mfa_code_ref01_data = vmap();
    ASSERT_TRUE(mfa_code_ref01_data.is_map(), "expected create result to be a map");
  }

}

int main() {
  T_RUN(mfa_code_entity_instance);
  T_RUN(mfa_code_entity_basic);
  return sdktest::summary("mfa_code_entity_test");
}
