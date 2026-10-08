// contactstrash entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class ContactstrashEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.Contactstrash()
    XCTAssertEqual(ent.getName(), "contactstrash")
  }

  // True when this SDK was generated with the named feature.
  static func hasFeature(_ name: String) -> Bool {
    gp(SdkConfig.makeConfig(), "feature").asMap?.entries[name] != nil
  }
}
