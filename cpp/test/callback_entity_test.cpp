// Generated basic-flow test for the callback entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct CallbackSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static CallbackSetup callback_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/callback/CallbackTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("callback01"), Value("callback02"), Value("callback03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_CALLBACK_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_CALLBACK_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  CallbackSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void callback_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->callback();
  ASSERT_EQ(ent->getName(), std::string("callback"), "entity name");
}


static void callback_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"callback", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = SmsapiSDK::testSDK(seed, sdkopts);
  auto se = strsdk->callback();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = SmsapiSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->callback();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static void callback_entity_basic() {
  auto setup = callback_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create", "list", "update", "load", "remove"}) {
    auto sk = is_control_skipped("entityOp", std::string("callback.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto callback_ref01_ent = client->callback();
  Value callback_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "callback"}), "callback_ref01"));
  if (!callback_ref01_data.is_map()) callback_ref01_data = vmap();
  {
    Value callback_ref01_data_result = callback_ref01_ent->create(Struct::clone(callback_ref01_data), Value::undef())->data();
    callback_ref01_data = Helpers::toMapAny(callback_ref01_data_result);
    if (!callback_ref01_data.is_map()) callback_ref01_data = vmap();
    ASSERT_TRUE(callback_ref01_data.is_map(), "expected create result to be a map");
    ASSERT_TRUE(!getp(callback_ref01_data, "id").is_undef(), "expected created entity to have an id");
  }

  // LIST
  Value callback_ref01_match = vmap();
  auto callback_ref01_list_ents = callback_ref01_ent->list(Struct::clone(callback_ref01_match), Value::undef());
  // list resolves to one ENTITY per record; the flow asserts on the records.
  Value callback_ref01_list = vlist();
  for (const auto& e : callback_ref01_list_ents) { callback_ref01_list.as_list()->push_back(e->data()); }
  ASSERT_TRUE(callback_ref01_list.is_list(), "expected list result to be an array");
  {
    std::vector<Value> found = Struct::select(entity_list_to_data(callback_ref01_list), vmap({{"id", getp(callback_ref01_data, "id")}}));
    ASSERT_TRUE(!found.empty(), "expected to find created entity in list");
  }

  // UPDATE
  Value callback_ref01_data_up0_up = vmap();
  setp(callback_ref01_data_up0_up, "id", getp(callback_ref01_data, "id"));
  std::string callback_ref01_data_up0_markval = std::string("Mark01-callback_ref01_") + std::to_string(setup.now);
  setp(callback_ref01_data_up0_up, "receiver_type", Value(callback_ref01_data_up0_markval));
  Value callback_ref01_resdata_up0_result = callback_ref01_ent->update(Struct::clone(callback_ref01_data_up0_up), Value::undef())->data();
  Value callback_ref01_resdata_up0 = Helpers::toMapAny(callback_ref01_resdata_up0_result);
  if (!callback_ref01_resdata_up0.is_map()) callback_ref01_resdata_up0 = vmap();
  ASSERT_TRUE(callback_ref01_resdata_up0.is_map(), "expected update result to be a map");
  ASSERT_EQ_VAL(getp(callback_ref01_resdata_up0, "id"), getp(callback_ref01_data_up0_up, "id"), "expected update result id to match");
  ASSERT_EQ_VAL(getp(callback_ref01_resdata_up0, "receiver_type"), Value(callback_ref01_data_up0_markval), "expected receiver_type to be updated");

  // LOAD
  Value callback_ref01_match_dt0 = vmap({{"id", getp(callback_ref01_data, "id")}});
  Value callback_ref01_data_dt0_loaded = callback_ref01_ent->load(Struct::clone(callback_ref01_match_dt0), Value::undef())->data();
  Value callback_ref01_data_dt0_load_result = Helpers::toMapAny(callback_ref01_data_dt0_loaded);
  ASSERT_TRUE(callback_ref01_data_dt0_load_result.is_map(), "expected load result to be a map");
  ASSERT_EQ_VAL(getp(callback_ref01_data_dt0_load_result, "id"), getp(callback_ref01_data, "id"), "expected load result id to match");

  // REMOVE
  {
    Value callback_ref01_match_rm0 = vmap({{"id", getp(callback_ref01_data, "id")}});
    callback_ref01_ent->remove(Struct::clone(callback_ref01_match_rm0), Value::undef());
  }

  // LIST
  Value callback_ref01_match_rt0 = vmap();
  auto callback_ref01_list_rt0_ents = callback_ref01_ent->list(Struct::clone(callback_ref01_match_rt0), Value::undef());
  // list resolves to one ENTITY per record; the flow asserts on the records.
  Value callback_ref01_list_rt0 = vlist();
  for (const auto& e : callback_ref01_list_rt0_ents) { callback_ref01_list_rt0.as_list()->push_back(e->data()); }
  ASSERT_TRUE(callback_ref01_list_rt0.is_list(), "expected list result to be an array");
  {
    std::vector<Value> found = Struct::select(entity_list_to_data(callback_ref01_list_rt0), vmap({{"id", getp(callback_ref01_data, "id")}}));
    ASSERT_TRUE(found.empty(), "expected removed entity to not be in list");
  }

}

int main() {
  T_RUN(callback_entity_instance);
  T_RUN(callback_entity_stream);
  T_RUN(callback_entity_basic);
  return sdktest::summary("callback_entity_test");
}
