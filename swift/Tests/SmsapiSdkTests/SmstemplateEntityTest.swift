// smstemplate entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class SmstemplateEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.Smstemplate()
    XCTAssertEqual(ent.getName(), "smstemplate")
  }

  // An invalid request fails with validate's own error, before it is sent.
  func testValidate() throws {
    try XCTSkipUnless(SmstemplateEntityTest.hasFeature("validate"), "feature not present in this SDK: validate")
    let client = SmsapiSDK.testSDK(nil, vm(("feature", .map(vm(("validate", .map(vm(("active", .bool(true))))))))))
    var err: Error? = nil
    do { _ = try client.Smstemplate().remove(vm(("id", .int(1))), nil) } catch { err = error }
    XCTAssertEqual((err as? SmsapiError)?.code, "validate_failed",
      "expected validate_failed, got \(String(describing: err))")
  }

  // True when this SDK was generated with the named feature.
  static func hasFeature(_ name: String) -> Bool {
    gp(SdkConfig.makeConfig(), "feature").asMap?.entries[name] != nil
  }
}
