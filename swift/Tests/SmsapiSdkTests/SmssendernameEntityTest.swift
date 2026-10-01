// smssendername entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class SmssendernameEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.Smssendername()
    XCTAssertEqual(ent.getName(), "smssendername")
  }
}
