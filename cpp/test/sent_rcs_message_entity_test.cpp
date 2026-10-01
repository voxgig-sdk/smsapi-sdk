// Generated basic-flow test for the sent_rcs_message entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct SentRcsMessageSetup {
  std::shared_ptr<SmsapiSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static SentRcsMessageSetup sent_rcs_message_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/sent_rcs_message/SentRcsMessageTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = SmsapiSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("sent_rcs_message01"), Value("sent_rcs_message02"), Value("sent_rcs_message03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"SMSAPI_TEST_SENT_RCS_MESSAGE_ENTID", idmap},
    {"SMSAPI_TEST_LIVE", Value("FALSE")},
    {"SMSAPI_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "SMSAPI_TEST_SENT_RCS_MESSAGE_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "SMSAPI_TEST_LIVE") == Value("TRUE");

  SentRcsMessageSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void sent_rcs_message_entity_instance() {
  auto testsdk = SmsapiSDK::testSDK();
  auto ent = testsdk->sent_rcs_message();
  ASSERT_EQ(ent->getName(), std::string("sent_rcs_message"), "entity name");
}


static void sent_rcs_message_entity_basic() {
  auto setup = sent_rcs_message_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create"}) {
    auto sk = is_control_skipped("entityOp", std::string("sent_rcs_message.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto sent_rcs_message_ref01_ent = client->sent_rcs_message();
  Value sent_rcs_message_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "sent_rcs_message"}), "sent_rcs_message_ref01"));
  if (!sent_rcs_message_ref01_data.is_map()) sent_rcs_message_ref01_data = vmap();
  {
    Value sent_rcs_message_ref01_data_result = sent_rcs_message_ref01_ent->create(Struct::clone(sent_rcs_message_ref01_data), Value::undef())->data();
    sent_rcs_message_ref01_data = Helpers::toMapAny(sent_rcs_message_ref01_data_result);
    if (!sent_rcs_message_ref01_data.is_map()) sent_rcs_message_ref01_data = vmap();
    ASSERT_TRUE(sent_rcs_message_ref01_data.is_map(), "expected create result to be a map");
  }

}

int main() {
  T_RUN(sent_rcs_message_entity_instance);
  T_RUN(sent_rcs_message_entity_basic);
  return sdktest::summary("sent_rcs_message_entity_test");
}
