// Generated basic-flow test for the opt_out_setting entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct OptOutSettingSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static OptOutSettingSetup opt_out_setting_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/opt_out_setting/OptOutSettingTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("opt_out_setting01"), Value("opt_out_setting02"), Value("opt_out_setting03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_OPT_OUT_SETTING_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_OPT_OUT_SETTING_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  OptOutSettingSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void opt_out_setting_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->opt_out_setting();
  ASSERT_EQ(ent->getName(), std::string("opt_out_setting"), "entity name");
}


static void opt_out_setting_entity_basic() {
  auto setup = opt_out_setting_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"update", "load"}) {
    auto sk = is_control_skipped("entityOp", std::string("opt_out_setting.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;

  // Bootstrap entity data from existing test data (no create step in flow).
  // Declare _data at FUNCTION scope (later load/update steps reference it);
  // only _data_raw was declared, so the block-local assignment left _data
  // undeclared ("was not declared in this scope").
  Value opt_out_setting_ref01_data_raw = Helpers::toMapAny(Struct::getpath(setup.data, {"existing", "opt_out_setting"}));
  Value opt_out_setting_ref01_data = vmap();
  {
    std::vector<Value> its = Struct::items(opt_out_setting_ref01_data_raw);
    opt_out_setting_ref01_data = its.empty() ? vmap() : Helpers::toMapAny(pair_val(its[0]));
    if (!opt_out_setting_ref01_data.is_map()) opt_out_setting_ref01_data = vmap();
  }
  // UPDATE
  auto opt_out_setting_ref01_ent = client->opt_out_setting();
  Value opt_out_setting_ref01_data_up0_up = vmap();
  std::string opt_out_setting_ref01_data_up0_markval = std::string("Mark01-opt_out_setting_ref01_") + std::to_string(setup.now);
  setp(opt_out_setting_ref01_data_up0_up, "brand", Value(opt_out_setting_ref01_data_up0_markval));
  Value opt_out_setting_ref01_resdata_up0_result = opt_out_setting_ref01_ent->update(Struct::clone(opt_out_setting_ref01_data_up0_up), Value::undef())->data();
  Value opt_out_setting_ref01_resdata_up0 = Helpers::toMapAny(opt_out_setting_ref01_resdata_up0_result);
  if (!opt_out_setting_ref01_resdata_up0.is_map()) opt_out_setting_ref01_resdata_up0 = vmap();
  ASSERT_TRUE(opt_out_setting_ref01_resdata_up0.is_map(), "expected update result to be a map");
  ASSERT_EQ_VAL(getp(opt_out_setting_ref01_resdata_up0, "brand"), Value(opt_out_setting_ref01_data_up0_markval), "expected brand to be updated");

  // LOAD
  Value opt_out_setting_ref01_match_dt0 = vmap();
  Value opt_out_setting_ref01_data_dt0_loaded = opt_out_setting_ref01_ent->load(opt_out_setting_ref01_match_dt0, Value::undef())->data();
  ASSERT_TRUE(!opt_out_setting_ref01_data_dt0_loaded.is_undef(), "expected load result to be non-nil");

}

int main() {
  T_RUN(opt_out_setting_entity_instance);
  T_RUN(opt_out_setting_entity_basic);
  return sdktest::summary("opt_out_setting_entity_test");
}
