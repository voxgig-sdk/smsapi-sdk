// Generated basic-flow test for the smssendername entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct SmssendernameSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static SmssendernameSetup smssendername_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/smssendername/SmssendernameTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("smssendername01"), Value("smssendername02"), Value("smssendername03"), Value("sendername01"), Value("sendername02"), Value("sendername03"), Value("sender01")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_SMSSENDERNAME_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_SMSSENDERNAME_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  SmssendernameSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void smssendername_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->smssendername();
  ASSERT_EQ(ent->getName(), std::string("smssendername"), "entity name");
}


static bool smssendername_has_feature(const std::string& name) {
  Value fm = Helpers::toMapAny(getp(sharedConfig(), "feature"));
  return fm.is_map() && !getp(fm, name).is_undef();
}

static void smssendername_entity_validate() {
  if (!smssendername_has_feature("validate")) {
    std::cerr << "skip: feature not present in this SDK: validate\n";
    return;
  }
  auto vsdk = SmsapiSDK::testSDK(Value::undef(), vmap({{"feature",
      vmap({{"validate", vmap({{"active", Value(true)}})}})}}));
  std::string code;
  try {
    vsdk->smssendername()->create(vmap({{"sender", Value(1)}}), Value::undef());
  } catch (const SdkErrorPtr& err) {
    code = err->code;
  }
  ASSERT_EQ(code, std::string("validate_failed"), "an invalid request fails with validate_failed");
}

static void smssendername_entity_basic() {
  auto setup = smssendername_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create", "remove"}) {
    auto sk = is_control_skipped("entityOp", std::string("smssendername.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto smssendername_ref01_ent = client->smssendername();
  Value smssendername_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "smssendername"}), "smssendername_ref01"));
  if (!smssendername_ref01_data.is_map()) smssendername_ref01_data = vmap();
  setp(smssendername_ref01_data, "sender", getp(setup.idmap, "sender01"));
  {
    Value smssendername_ref01_data_result = smssendername_ref01_ent->create(Struct::clone(smssendername_ref01_data), Value::undef())->data();
    smssendername_ref01_data = Helpers::toMapAny(smssendername_ref01_data_result);
    if (!smssendername_ref01_data.is_map()) smssendername_ref01_data = vmap();
    ASSERT_TRUE(smssendername_ref01_data.is_map(), "expected create result to be a map");
  }

  // REMOVE
  {
    Value smssendername_ref01_match_rm0 = vmap({{"id", getp(smssendername_ref01_data, "id")}});
    smssendername_ref01_ent->remove(Struct::clone(smssendername_ref01_match_rm0), Value::undef());
  }

}

int main() {
  T_RUN(smssendername_entity_instance);
  T_RUN(smssendername_entity_validate);
  T_RUN(smssendername_entity_basic);
  return sdktest::summary("smssendername_entity_test");
}
