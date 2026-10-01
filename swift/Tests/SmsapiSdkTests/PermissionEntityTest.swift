// permission entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class PermissionEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.Permission()
    XCTAssertEqual(ent.getName(), "permission")
  }
}
