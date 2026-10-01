// Generated instance test for the smsdo entity.

#include "ctest.h"

int main(void) {
  SmsapiSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = smsapi_smsdo(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "smsdo", "entity get_name");

  TEST_SUMMARY("smsdo_entity");
}
