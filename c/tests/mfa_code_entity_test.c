// Generated instance test for the mfa_code entity.

#include "ctest.h"

int main(void) {
  SmsapiSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = smsapi_mfa_code(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "mfa_code", "entity get_name");

  TEST_SUMMARY("mfa_code_entity");
}
