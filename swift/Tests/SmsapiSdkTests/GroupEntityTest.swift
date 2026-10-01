// group entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class GroupEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.Group()
    XCTAssertEqual(ent.getName(), "group")
  }
}
