// mfa_code entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class MfaCodeEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.MfaCode()
    XCTAssertEqual(ent.getName(), "mfa_code")
  }
}
