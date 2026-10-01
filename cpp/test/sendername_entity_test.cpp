// Generated basic-flow test for the sendername entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct SendernameSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static SendernameSetup sendername_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/sendername/SendernameTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("sendername01"), Value("sendername02"), Value("sendername03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_SENDERNAME_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_SENDERNAME_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  SendernameSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void sendername_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->sendername();
  ASSERT_EQ(ent->getName(), std::string("sendername"), "entity name");
}


static void sendername_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"sendername", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = SmsapiSDK::testSDK(seed, sdkopts);
  auto se = strsdk->sendername();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = SmsapiSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->sendername();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static void sendername_entity_basic() {
  auto setup = sendername_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create", "list", "load"}) {
    auto sk = is_control_skipped("entityOp", std::string("sendername.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto sendername_ref01_ent = client->sendername();
  Value sendername_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "sendername"}), "sendername_ref01"));
  if (!sendername_ref01_data.is_map()) sendername_ref01_data = vmap();
  {
    Value sendername_ref01_data_result = sendername_ref01_ent->create(Struct::clone(sendername_ref01_data), Value::undef())->data();
    sendername_ref01_data = Helpers::toMapAny(sendername_ref01_data_result);
    if (!sendername_ref01_data.is_map()) sendername_ref01_data = vmap();
    ASSERT_TRUE(sendername_ref01_data.is_map(), "expected create result to be a map");
    ASSERT_TRUE(!getp(sendername_ref01_data, "id").is_undef(), "expected created entity to have an id");
  }

  // LIST
  Value sendername_ref01_match = vmap();
  auto sendername_ref01_list_ents = sendername_ref01_ent->list(Struct::clone(sendername_ref01_match), Value::undef());
  // list resolves to one ENTITY per record; the flow asserts on the records.
  Value sendername_ref01_list = vlist();
  for (const auto& e : sendername_ref01_list_ents) { sendername_ref01_list.as_list()->push_back(e->data()); }
  ASSERT_TRUE(sendername_ref01_list.is_list(), "expected list result to be an array");
  {
    std::vector<Value> found = Struct::select(entity_list_to_data(sendername_ref01_list), vmap({{"id", getp(sendername_ref01_data, "id")}}));
    ASSERT_TRUE(!found.empty(), "expected to find created entity in list");
  }

  // LOAD
  Value sendername_ref01_match_dt0 = vmap({{"id", getp(sendername_ref01_data, "id")}});
  Value sendername_ref01_data_dt0_loaded = sendername_ref01_ent->load(Struct::clone(sendername_ref01_match_dt0), Value::undef())->data();
  Value sendername_ref01_data_dt0_load_result = Helpers::toMapAny(sendername_ref01_data_dt0_loaded);
  ASSERT_TRUE(sendername_ref01_data_dt0_load_result.is_map(), "expected load result to be a map");
  ASSERT_EQ_VAL(getp(sendername_ref01_data_dt0_load_result, "id"), getp(sendername_ref01_data, "id"), "expected load result id to match");

}

int main() {
  T_RUN(sendername_entity_instance);
  T_RUN(sendername_entity_stream);
  T_RUN(sendername_entity_basic);
  return sdktest::summary("sendername_entity_test");
}
