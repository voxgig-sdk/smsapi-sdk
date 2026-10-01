// Generated instance test for the sent_rcs_message entity.

#include "ctest.h"

int main(void) {
  SmsapiSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = smsapi_sent_rcs_message(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "sent_rcs_message", "entity get_name");

  TEST_SUMMARY("sent_rcs_message_entity");
}
