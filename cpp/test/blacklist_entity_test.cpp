// Generated basic-flow test for the blacklist entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct BlacklistSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static BlacklistSetup blacklist_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/blacklist/BlacklistTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("blacklist01"), Value("blacklist02"), Value("blacklist03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_BLACKLIST_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_BLACKLIST_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  BlacklistSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void blacklist_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->blacklist();
  ASSERT_EQ(ent->getName(), std::string("blacklist"), "entity name");
}


static void blacklist_entity_basic() {
  auto setup = blacklist_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create", "load", "remove"}) {
    auto sk = is_control_skipped("entityOp", std::string("blacklist.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto blacklist_ref01_ent = client->blacklist();
  Value blacklist_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "blacklist"}), "blacklist_ref01"));
  if (!blacklist_ref01_data.is_map()) blacklist_ref01_data = vmap();
  {
    Value blacklist_ref01_data_result = blacklist_ref01_ent->create(Struct::clone(blacklist_ref01_data), Value::undef())->data();
    blacklist_ref01_data = Helpers::toMapAny(blacklist_ref01_data_result);
    if (!blacklist_ref01_data.is_map()) blacklist_ref01_data = vmap();
    ASSERT_TRUE(blacklist_ref01_data.is_map(), "expected create result to be a map");
    ASSERT_TRUE(!getp(blacklist_ref01_data, "id").is_undef(), "expected created entity to have an id");
  }

  // LOAD
  Value blacklist_ref01_match_dt0 = vmap({{"id", getp(blacklist_ref01_data, "id")}});
  Value blacklist_ref01_data_dt0_loaded = blacklist_ref01_ent->load(Struct::clone(blacklist_ref01_match_dt0), Value::undef())->data();
  Value blacklist_ref01_data_dt0_load_result = Helpers::toMapAny(blacklist_ref01_data_dt0_loaded);
  ASSERT_TRUE(blacklist_ref01_data_dt0_load_result.is_map(), "expected load result to be a map");
  ASSERT_EQ_VAL(getp(blacklist_ref01_data_dt0_load_result, "id"), getp(blacklist_ref01_data, "id"), "expected load result id to match");

  // REMOVE
  {
    Value blacklist_ref01_match_rm0 = vmap({{"id", getp(blacklist_ref01_data, "id")}});
    blacklist_ref01_ent->remove(Struct::clone(blacklist_ref01_match_rm0), Value::undef());
  }

}

int main() {
  T_RUN(blacklist_entity_instance);
  T_RUN(blacklist_entity_basic);
  return sdktest::summary("blacklist_entity_test");
}
