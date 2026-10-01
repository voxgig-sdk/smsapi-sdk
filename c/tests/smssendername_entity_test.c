// Generated instance test for the smssendername entity.

#include "ctest.h"

int main(void) {
  SmsapiSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = smsapi_smssendername(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "smssendername", "entity get_name");

  TEST_SUMMARY("smssendername_entity");
}
