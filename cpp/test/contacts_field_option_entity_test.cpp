// Generated basic-flow test for the contacts_field_option entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct ContactsFieldOptionSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static ContactsFieldOptionSetup contacts_field_option_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/contacts_field_option/ContactsFieldOptionTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("contacts_field_option01"), Value("contacts_field_option02"), Value("contacts_field_option03"), Value("field01")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_CONTACTS_FIELD_OPTION_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_CONTACTS_FIELD_OPTION_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  ContactsFieldOptionSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void contacts_field_option_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->contacts_field_option();
  ASSERT_EQ(ent->getName(), std::string("contacts_field_option"), "entity name");
}


static bool contacts_field_option_has_feature(const std::string& name) {
  Value fm = Helpers::toMapAny(getp(sharedConfig(), "feature"));
  return fm.is_map() && !getp(fm, name).is_undef();
}

static void contacts_field_option_entity_validate() {
  if (!contacts_field_option_has_feature("validate")) {
    std::cerr << "skip: feature not present in this SDK: validate\n";
    return;
  }
  auto vsdk = SmsapiSDK::testSDK(Value::undef(), vmap({{"feature",
      vmap({{"validate", vmap({{"active", Value(true)}})}})}}));
  std::string code;
  try {
    vsdk->contacts_field_option()->list(vmap({{"field_id", Value(1)}}), Value::undef());
  } catch (const SdkErrorPtr& err) {
    code = err->code;
  }
  ASSERT_EQ(code, std::string("validate_failed"), "an invalid request fails with validate_failed");
}

static void contacts_field_option_entity_basic() {
  auto setup = contacts_field_option_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"list"}) {
    auto sk = is_control_skipped("entityOp", std::string("contacts_field_option.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;

  // Bootstrap entity data from existing test data (no create step in flow).
  // Declare _data at FUNCTION scope (later load/update steps reference it);
  // only _data_raw was declared, so the block-local assignment left _data
  // undeclared ("was not declared in this scope").
  Value contacts_field_option_ref01_data_raw = Helpers::toMapAny(Struct::getpath(setup.data, {"existing", "contacts_field_option"}));
  Value contacts_field_option_ref01_data = vmap();
  {
    std::vector<Value> its = Struct::items(contacts_field_option_ref01_data_raw);
    contacts_field_option_ref01_data = its.empty() ? vmap() : Helpers::toMapAny(pair_val(its[0]));
    if (!contacts_field_option_ref01_data.is_map()) contacts_field_option_ref01_data = vmap();
  }
  // LIST
  auto contacts_field_option_ref01_ent = client->contacts_field_option();
  Value contacts_field_option_ref01_match = vmap();
  setp(contacts_field_option_ref01_match, "field_id", getp(setup.idmap, "field01"));
  auto contacts_field_option_ref01_list_ents = contacts_field_option_ref01_ent->list(Struct::clone(contacts_field_option_ref01_match), Value::undef());
  // list resolves to one ENTITY per record; the flow asserts on the records.
  Value contacts_field_option_ref01_list = vlist();
  for (const auto& e : contacts_field_option_ref01_list_ents) { contacts_field_option_ref01_list.as_list()->push_back(e->data()); }
  ASSERT_TRUE(contacts_field_option_ref01_list.is_list(), "expected list result to be an array");

}

int main() {
  T_RUN(contacts_field_option_entity_instance);
  T_RUN(contacts_field_option_entity_validate);
  T_RUN(contacts_field_option_entity_basic);
  return sdktest::summary("contacts_field_option_entity_test");
}
