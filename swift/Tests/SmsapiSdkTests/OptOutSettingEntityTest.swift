// opt_out_setting entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class OptOutSettingEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.OptOutSetting()
    XCTAssertEqual(ent.getName(), "opt_out_setting")
  }
}
