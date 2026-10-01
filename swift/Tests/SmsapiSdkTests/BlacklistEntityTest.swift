// blacklist entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class BlacklistEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.Blacklist()
    XCTAssertEqual(ent.getName(), "blacklist")
  }
}
