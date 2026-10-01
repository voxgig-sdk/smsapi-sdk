// smsdo entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class SmsdoEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.Smsdo()
    XCTAssertEqual(ent.getName(), "smsdo")
  }
}
