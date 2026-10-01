// contactstrash entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class ContactstrashEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.Contactstrash()
    XCTAssertEqual(ent.getName(), "contactstrash")
  }
}
