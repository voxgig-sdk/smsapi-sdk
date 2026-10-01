// Generated basic-flow test for the permission entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct PermissionSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static PermissionSetup permission_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/permission/PermissionTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("permission01"), Value("permission02"), Value("permission03"), Value("group01"), Value("group02"), Value("group03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_PERMISSION_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_PERMISSION_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  PermissionSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void permission_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->permission();
  ASSERT_EQ(ent->getName(), std::string("permission"), "entity name");
}


static void permission_entity_basic() {
  auto setup = permission_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create", "load"}) {
    auto sk = is_control_skipped("entityOp", std::string("permission.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto permission_ref01_ent = client->permission();
  Value permission_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "permission"}), "permission_ref01"));
  if (!permission_ref01_data.is_map()) permission_ref01_data = vmap();
  setp(permission_ref01_data, "group_id", getp(setup.idmap, "group01"));
  {
    Value permission_ref01_data_result = permission_ref01_ent->create(Struct::clone(permission_ref01_data), Value::undef())->data();
    permission_ref01_data = Helpers::toMapAny(permission_ref01_data_result);
    if (!permission_ref01_data.is_map()) permission_ref01_data = vmap();
    ASSERT_TRUE(permission_ref01_data.is_map(), "expected create result to be a map");
    ASSERT_TRUE(!getp(permission_ref01_data, "id").is_undef(), "expected created entity to have an id");
  }

  // LOAD
  Value permission_ref01_match_dt0 = vmap({{"id", getp(permission_ref01_data, "id")}});
  Value permission_ref01_data_dt0_loaded = permission_ref01_ent->load(Struct::clone(permission_ref01_match_dt0), Value::undef())->data();
  Value permission_ref01_data_dt0_load_result = Helpers::toMapAny(permission_ref01_data_dt0_loaded);
  ASSERT_TRUE(permission_ref01_data_dt0_load_result.is_map(), "expected load result to be a map");
  ASSERT_EQ_VAL(getp(permission_ref01_data_dt0_load_result, "id"), getp(permission_ref01_data, "id"), "expected load result id to match");

}

int main() {
  T_RUN(permission_entity_instance);
  T_RUN(permission_entity_basic);
  return sdktest::summary("permission_entity_test");
}
