// sent_rcs_message entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class SentRcsMessageEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.SentRcsMessage()
    XCTAssertEqual(ent.getName(), "sent_rcs_message")
  }
}
