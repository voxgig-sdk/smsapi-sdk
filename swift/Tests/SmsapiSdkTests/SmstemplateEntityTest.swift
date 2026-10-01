// smstemplate entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class SmstemplateEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.Smstemplate()
    XCTAssertEqual(ent.getName(), "smstemplate")
  }
}
