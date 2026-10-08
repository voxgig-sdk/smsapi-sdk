// Generated basic-flow test for the contactsgroup entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct ContactsgroupSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static ContactsgroupSetup contactsgroup_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/contactsgroup/ContactsgroupTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("contactsgroup01"), Value("contactsgroup02"), Value("contactsgroup03"), Value("group01"), Value("group02"), Value("group03"), Value("permission01"), Value("permission02"), Value("permission03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_CONTACTSGROUP_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_CONTACTSGROUP_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  ContactsgroupSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void contactsgroup_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->contactsgroup();
  ASSERT_EQ(ent->getName(), std::string("contactsgroup"), "entity name");
}


static void contactsgroup_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"contactsgroup", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = SmsapiSDK::testSDK(seed, sdkopts);
  auto se = strsdk->contactsgroup();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = SmsapiSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->contactsgroup();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static bool contactsgroup_has_feature(const std::string& name) {
  Value fm = Helpers::toMapAny(getp(sharedConfig(), "feature"));
  return fm.is_map() && !getp(fm, name).is_undef();
}

class ContactsgroupFailHook : public BaseFeature {
public:
  int unexpected = 0;
  ContactsgroupFailHook() : BaseFeature("failhook", "0.0.1", true) {}
  void preSpec(CtxPtr ctx) override {
    throw std::runtime_error("contactsgroup hook failed");
  }
  void preUnexpected(CtxPtr ctx) override {
    unexpected++;
  }
};

static void contactsgroup_entity_stream_error() {
  Value offline = vmap({{"net", vmap({{"offline", Value(true)}})}});
  std::string msg;
  try {
    SmsapiSDK::testSDK(offline, Value::undef())->contactsgroup()
        ->stream("list", Value::undef(), Value::undef());
  } catch (const SdkErrorPtr& err) {
    msg = err->getMessage();
  }
  ASSERT_TRUE(msg.find("offline") != std::string::npos,
      "stream: a failed operation fails the stream");

  bool raised = false;
  try {
    SmsapiSDK::testSDK(offline, Value::undef())->contactsgroup()
        ->stream("list", Value::undef(), vmap({{"ctrl", vmap({{"throw", Value(false)}})}}));
  } catch (const SdkErrorPtr&) {
    raised = true;
  }
  ASSERT_FALSE(raised, "stream: under throw false a failed stream ends");

  if (contactsgroup_has_feature("rbac")) {
    std::string code;
    try {
      SmsapiSDK::testSDK(Value::undef(), vmap({{"feature", vmap({{"rbac",
          vmap({{"active", Value(true)}, {"deny", Value(true)}})}})}}))->contactsgroup()
          ->stream("list", Value::undef(), Value::undef());
    } catch (const SdkErrorPtr& err) {
      code = err->code;
    }
    ASSERT_EQ(code, std::string("rbac_denied"), "stream: a denied operation fails the stream");
  }
}

static void contactsgroup_entity_stream_ctrl() {
  Value explain = vmap();
  Value ctrl = vmap({{"explain", explain}});
  SmsapiSDK::testSDK()->contactsgroup()->stream("list", Value::undef(), vmap({{"ctrl", ctrl}}));
  ASSERT_TRUE(getp(ctrl, "stream").is_undef(), "stream: the caller's ctrl gains no key");
  ASSERT_TRUE(!explain.as_map()->empty(), "stream: the caller's explain record is filled");
}

static void contactsgroup_entity_unexpected() {
  auto hook = std::make_shared<ContactsgroupFailHook>();
  auto client = SmsapiSDK::testSDK();
  client->getRootCtx()->utility->featureAdd(client->getRootCtx(), hook);

  std::string msg;
  try {
    client->contactsgroup()->list(Value::undef(), Value::undef());
  } catch (const SdkErrorPtr& err) {
    msg = err->getMessage();
  }
  ASSERT_TRUE(msg.find("hook failed") != std::string::npos, "a throwing hook fails the operation");
  ASSERT_TRUE(0 < hook->unexpected, "a throwing hook fires PreUnexpected");

  int fired = hook->unexpected;
  client->contactsgroup()->list(Value::undef(), vmap({{"throw", Value(false)}}));
  ASSERT_TRUE(fired < hook->unexpected, "under throw false PreUnexpected fires too");
}

static void contactsgroup_entity_validate() {
  if (!contactsgroup_has_feature("validate")) {
    std::cerr << "skip: feature not present in this SDK: validate\n";
    return;
  }
  auto vsdk = SmsapiSDK::testSDK(Value::undef(), vmap({{"feature",
      vmap({{"validate", vmap({{"active", Value(true)}})}})}}));
  std::string code;
  try {
    vsdk->contactsgroup()->create(vmap({{"group_id", Value(1)}, {"read", Value(true)}, {"send", Value(true)}, {"username", Value("x")}, {"write", Value(true)}}), Value::undef());
  } catch (const SdkErrorPtr& err) {
    code = err->code;
  }
  ASSERT_EQ(code, std::string("validate_failed"), "an invalid request fails with validate_failed");
}

static void contactsgroup_entity_basic() {
  auto setup = contactsgroup_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create", "list", "update", "remove"}) {
    auto sk = is_control_skipped("entityOp", std::string("contactsgroup.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto contactsgroup_ref01_ent = client->contactsgroup();
  Value contactsgroup_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "contactsgroup"}), "contactsgroup_ref01"));
  if (!contactsgroup_ref01_data.is_map()) contactsgroup_ref01_data = vmap();
  setp(contactsgroup_ref01_data, "group_id", getp(setup.idmap, "group01"));
  {
    Value contactsgroup_ref01_data_result = contactsgroup_ref01_ent->create(Struct::clone(contactsgroup_ref01_data), Value::undef())->data();
    contactsgroup_ref01_data = Helpers::toMapAny(contactsgroup_ref01_data_result);
    if (!contactsgroup_ref01_data.is_map()) contactsgroup_ref01_data = vmap();
    ASSERT_TRUE(contactsgroup_ref01_data.is_map(), "expected create result to be a map");
  }

  // LIST
  Value contactsgroup_ref01_match = vmap();
  auto contactsgroup_ref01_list_ents = contactsgroup_ref01_ent->list(Struct::clone(contactsgroup_ref01_match), Value::undef());
  // list resolves to one ENTITY per record; the flow asserts on the records.
  Value contactsgroup_ref01_list = vlist();
  for (const auto& e : contactsgroup_ref01_list_ents) { contactsgroup_ref01_list.as_list()->push_back(e->data()); }
  ASSERT_TRUE(contactsgroup_ref01_list.is_list(), "expected list result to be an array");
  {
    std::vector<Value> found = Struct::select(entity_list_to_data(contactsgroup_ref01_list), vmap({{"id", getp(contactsgroup_ref01_data, "id")}}));
    ASSERT_TRUE(!found.empty(), "expected to find created entity in list");
  }

  // UPDATE
  Value contactsgroup_ref01_data_up0_up = vmap();
  Value contactsgroup_ref01_resdata_up0_result = contactsgroup_ref01_ent->update(Struct::clone(contactsgroup_ref01_data_up0_up), Value::undef())->data();
  Value contactsgroup_ref01_resdata_up0 = Helpers::toMapAny(contactsgroup_ref01_resdata_up0_result);
  if (!contactsgroup_ref01_resdata_up0.is_map()) contactsgroup_ref01_resdata_up0 = vmap();
  ASSERT_TRUE(contactsgroup_ref01_resdata_up0.is_map(), "expected update result to be a map");

  // REMOVE
  {
    Value contactsgroup_ref01_match_rm0 = vmap({{"id", getp(contactsgroup_ref01_data, "id")}});
    contactsgroup_ref01_ent->remove(Struct::clone(contactsgroup_ref01_match_rm0), Value::undef());
  }

  // LIST
  Value contactsgroup_ref01_match_rt0 = vmap();
  auto contactsgroup_ref01_list_rt0_ents = contactsgroup_ref01_ent->list(Struct::clone(contactsgroup_ref01_match_rt0), Value::undef());
  // list resolves to one ENTITY per record; the flow asserts on the records.
  Value contactsgroup_ref01_list_rt0 = vlist();
  for (const auto& e : contactsgroup_ref01_list_rt0_ents) { contactsgroup_ref01_list_rt0.as_list()->push_back(e->data()); }
  ASSERT_TRUE(contactsgroup_ref01_list_rt0.is_list(), "expected list result to be an array");
  {
    std::vector<Value> found = Struct::select(entity_list_to_data(contactsgroup_ref01_list_rt0), vmap({{"id", getp(contactsgroup_ref01_data, "id")}}));
    ASSERT_TRUE(found.empty(), "expected removed entity to not be in list");
  }

}

int main() {
  T_RUN(contactsgroup_entity_instance);
  T_RUN(contactsgroup_entity_stream);
  T_RUN(contactsgroup_entity_stream_error);
  T_RUN(contactsgroup_entity_stream_ctrl);
  T_RUN(contactsgroup_entity_unexpected);
  T_RUN(contactsgroup_entity_validate);
  T_RUN(contactsgroup_entity_basic);
  return sdktest::summary("contactsgroup_entity_test");
}
