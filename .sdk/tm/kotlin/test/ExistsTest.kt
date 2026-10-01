package KOTLINPACKAGE.sdktest

import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Test

import KOTLINPACKAGE.core.SmsapiSDK

class ExistsTest {

  @Test
  fun testMode() {
    val testsdk = SmsapiSDK.testSDK()
    assertNotNull(testsdk, "expected non-nil SDK")
  }
}
