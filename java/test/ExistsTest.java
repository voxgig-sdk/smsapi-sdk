package voxgig.smsapisdk.sdktest;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

import voxgig.smsapisdk.core.SmsapiSDK;

public class ExistsTest {

  @Test
  public void testMode() {
    SmsapiSDK testsdk = SmsapiSDK.testSDK();
    assertNotNull(testsdk, "expected non-nil SDK");
  }
}
