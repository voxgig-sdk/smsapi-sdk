package voxgig.smsapisdk.sdktest

import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Test

import voxgig.smsapisdk.core.SmsapiSDK

class ExistsTest {

  @Test
  fun testMode() {
    val testsdk = SmsapiSDK.testSDK()
    assertNotNull(testsdk, "expected non-nil SDK")
  }
}
