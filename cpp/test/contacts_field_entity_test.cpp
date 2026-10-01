// Generated basic-flow test for the contacts_field entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct ContactsFieldSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static ContactsFieldSetup contacts_field_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/contacts_field/ContactsFieldTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("contacts_field01"), Value("contacts_field02"), Value("contacts_field03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_CONTACTS_FIELD_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_CONTACTS_FIELD_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  ContactsFieldSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void contacts_field_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->contacts_field();
  ASSERT_EQ(ent->getName(), std::string("contacts_field"), "entity name");
}


static void contacts_field_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"contacts_field", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = SmsapiSDK::testSDK(seed, sdkopts);
  auto se = strsdk->contacts_field();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = SmsapiSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->contacts_field();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static void contacts_field_entity_basic() {
  auto setup = contacts_field_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create", "list", "update", "remove"}) {
    auto sk = is_control_skipped("entityOp", std::string("contacts_field.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto contacts_field_ref01_ent = client->contacts_field();
  Value contacts_field_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "contacts_field"}), "contacts_field_ref01"));
  if (!contacts_field_ref01_data.is_map()) contacts_field_ref01_data = vmap();
  {
    Value contacts_field_ref01_data_result = contacts_field_ref01_ent->create(Struct::clone(contacts_field_ref01_data), Value::undef())->data();
    contacts_field_ref01_data = Helpers::toMapAny(contacts_field_ref01_data_result);
    if (!contacts_field_ref01_data.is_map()) contacts_field_ref01_data = vmap();
    ASSERT_TRUE(contacts_field_ref01_data.is_map(), "expected create result to be a map");
    ASSERT_TRUE(!getp(contacts_field_ref01_data, "id").is_undef(), "expected created entity to have an id");
  }

  // LIST
  Value contacts_field_ref01_match = vmap();
  auto contacts_field_ref01_list_ents = contacts_field_ref01_ent->list(Struct::clone(contacts_field_ref01_match), Value::undef());
  // list resolves to one ENTITY per record; the flow asserts on the records.
  Value contacts_field_ref01_list = vlist();
  for (const auto& e : contacts_field_ref01_list_ents) { contacts_field_ref01_list.as_list()->push_back(e->data()); }
  ASSERT_TRUE(contacts_field_ref01_list.is_list(), "expected list result to be an array");
  {
    std::vector<Value> found = Struct::select(entity_list_to_data(contacts_field_ref01_list), vmap({{"id", getp(contacts_field_ref01_data, "id")}}));
    ASSERT_TRUE(!found.empty(), "expected to find created entity in list");
  }

  // UPDATE
  Value contacts_field_ref01_data_up0_up = vmap();
  setp(contacts_field_ref01_data_up0_up, "id", getp(contacts_field_ref01_data, "id"));
  std::string contacts_field_ref01_data_up0_markval = std::string("Mark01-contacts_field_ref01_") + std::to_string(setup.now);
  setp(contacts_field_ref01_data_up0_up, "birthday_date", Value(contacts_field_ref01_data_up0_markval));
  Value contacts_field_ref01_resdata_up0_result = contacts_field_ref01_ent->update(Struct::clone(contacts_field_ref01_data_up0_up), Value::undef())->data();
  Value contacts_field_ref01_resdata_up0 = Helpers::toMapAny(contacts_field_ref01_resdata_up0_result);
  if (!contacts_field_ref01_resdata_up0.is_map()) contacts_field_ref01_resdata_up0 = vmap();
  ASSERT_TRUE(contacts_field_ref01_resdata_up0.is_map(), "expected update result to be a map");
  ASSERT_EQ_VAL(getp(contacts_field_ref01_resdata_up0, "id"), getp(contacts_field_ref01_data_up0_up, "id"), "expected update result id to match");
  ASSERT_EQ_VAL(getp(contacts_field_ref01_resdata_up0, "birthday_date"), Value(contacts_field_ref01_data_up0_markval), "expected birthday_date to be updated");

  // REMOVE
  {
    Value contacts_field_ref01_match_rm0 = vmap({{"id", getp(contacts_field_ref01_data, "id")}});
    contacts_field_ref01_ent->remove(Struct::clone(contacts_field_ref01_match_rm0), Value::undef());
  }

  // LIST
  Value contacts_field_ref01_match_rt0 = vmap();
  auto contacts_field_ref01_list_rt0_ents = contacts_field_ref01_ent->list(Struct::clone(contacts_field_ref01_match_rt0), Value::undef());
  // list resolves to one ENTITY per record; the flow asserts on the records.
  Value contacts_field_ref01_list_rt0 = vlist();
  for (const auto& e : contacts_field_ref01_list_rt0_ents) { contacts_field_ref01_list_rt0.as_list()->push_back(e->data()); }
  ASSERT_TRUE(contacts_field_ref01_list_rt0.is_list(), "expected list result to be an array");
  {
    std::vector<Value> found = Struct::select(entity_list_to_data(contacts_field_ref01_list_rt0), vmap({{"id", getp(contacts_field_ref01_data, "id")}}));
    ASSERT_TRUE(found.empty(), "expected removed entity to not be in list");
  }

}

int main() {
  T_RUN(contacts_field_entity_instance);
  T_RUN(contacts_field_entity_stream);
  T_RUN(contacts_field_entity_basic);
  return sdktest::summary("contacts_field_entity_test");
}
