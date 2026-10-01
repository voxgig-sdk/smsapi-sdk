// Smsapi SDK exists test.

import XCTest

@testable import SmsapiSdk

final class ExistsTest: XCTestCase {
  func testMode() {
    let testsdk = SmsapiSDK.testSDK(nil, nil)
    XCTAssertEqual(testsdk.mode, "test")
  }
}
