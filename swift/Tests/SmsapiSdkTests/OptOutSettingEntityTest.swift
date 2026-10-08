// opt_out_setting entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class OptOutSettingEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.OptOutSetting()
    XCTAssertEqual(ent.getName(), "opt_out_setting")
  }

  // An invalid request fails with validate's own error, before it is sent.
  func testValidate() throws {
    try XCTSkipUnless(OptOutSettingEntityTest.hasFeature("validate"), "feature not present in this SDK: validate")
    let client = SmsapiSDK.testSDK(nil, vm(("feature", .map(vm(("validate", .map(vm(("active", .bool(true))))))))))
    var err: Error? = nil
    do { _ = try client.OptOutSetting().load(vm(("brand", .int(1))), nil) } catch { err = error }
    XCTAssertEqual((err as? SmsapiError)?.code, "validate_failed",
      "expected validate_failed, got \(String(describing: err))")
  }

  // True when this SDK was generated with the named feature.
  static func hasFeature(_ name: String) -> Bool {
    gp(SdkConfig.makeConfig(), "feature").asMap?.entries[name] != nil
  }
}
