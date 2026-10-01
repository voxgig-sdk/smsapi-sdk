// Generated basic-flow test for the contactstrash entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct ContactstrashSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static ContactstrashSetup contactstrash_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/contactstrash/ContactstrashTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("contactstrash01"), Value("contactstrash02"), Value("contactstrash03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_CONTACTSTRASH_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_CONTACTSTRASH_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  ContactstrashSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void contactstrash_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->contactstrash();
  ASSERT_EQ(ent->getName(), std::string("contactstrash"), "entity name");
}


static void contactstrash_entity_basic() {
  auto setup = contactstrash_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"update"}) {
    auto sk = is_control_skipped("entityOp", std::string("contactstrash.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;

  // Bootstrap entity data from existing test data (no create step in flow).
  // Declare _data at FUNCTION scope (later load/update steps reference it);
  // only _data_raw was declared, so the block-local assignment left _data
  // undeclared ("was not declared in this scope").
  Value contactstrash_ref01_data_raw = Helpers::toMapAny(Struct::getpath(setup.data, {"existing", "contactstrash"}));
  Value contactstrash_ref01_data = vmap();
  {
    std::vector<Value> its = Struct::items(contactstrash_ref01_data_raw);
    contactstrash_ref01_data = its.empty() ? vmap() : Helpers::toMapAny(pair_val(its[0]));
    if (!contactstrash_ref01_data.is_map()) contactstrash_ref01_data = vmap();
  }
  // UPDATE
  auto contactstrash_ref01_ent = client->contactstrash();
  Value contactstrash_ref01_data_up0_up = vmap();
  Value contactstrash_ref01_resdata_up0_result = contactstrash_ref01_ent->update(Struct::clone(contactstrash_ref01_data_up0_up), Value::undef())->data();
  Value contactstrash_ref01_resdata_up0 = Helpers::toMapAny(contactstrash_ref01_resdata_up0_result);
  if (!contactstrash_ref01_resdata_up0.is_map()) contactstrash_ref01_resdata_up0 = vmap();
  ASSERT_TRUE(contactstrash_ref01_resdata_up0.is_map(), "expected update result to be a map");

}

int main() {
  T_RUN(contactstrash_entity_instance);
  T_RUN(contactstrash_entity_basic);
  return sdktest::summary("contactstrash_entity_test");
}
