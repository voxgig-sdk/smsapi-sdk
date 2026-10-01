// Generated instance test for the opt_out_setting entity.

#include "ctest.h"

int main(void) {
  SmsapiSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = smsapi_opt_out_setting(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "opt_out_setting", "entity get_name");

  TEST_SUMMARY("opt_out_setting_entity");
}
