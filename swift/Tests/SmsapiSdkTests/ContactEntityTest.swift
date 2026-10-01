// contact entity test (generated from the API model).

import XCTest

@testable import SmsapiSdk

final class ContactEntityTest: XCTestCase {
  func testInstance() {
    let sdk = SmsapiSDK.testSDK(nil, nil)
    let ent = sdk.Contact()
    XCTAssertEqual(ent.getName(), "contact")
  }

  func testStream() async throws {
    // Seed two records (under the test feature's entity key) and activate
    // the streaming feature.
    let fixtures = vm(("entity", .map(vm(("contact", .map(vm(
      ("s1", .map(vm(("id", .string("s1"))))),
      ("s2", .map(vm(("id", .string("s2"))))))))))))
    let sdkopts = vm(
      ("feature", .map(vm(("streaming", .map(vm(("active", .bool(true)))))))))
    let sdk = SmsapiSDK.testSDK(fixtures, sdkopts)
    let ent = sdk.Contact()

    // Materialised list result for the same op.
    let listed = try ent.list(VMap(), nil)
    let listedN = listed.asList?.items.count ?? 0

    // stream("list") yields items via the streaming feature's iterator.
    var streamed: [Value] = []
    let seq = try ent.stream("list", VMap(), nil)
    for await item in seq { streamed.append(item) }
    XCTAssertGreaterThan(streamed.count, 0, "expected stream to yield items")
    XCTAssertEqual(streamed.count, listedN)

    // Fallback: with streaming inactive, stream still yields the materialised
    // items.
    let sdk2 = SmsapiSDK.testSDK(fixtures, nil)
    let ent2 = sdk2.Contact()
    var streamed2: [Value] = []
    let seq2 = try ent2.stream("list", VMap(), nil)
    for await item in seq2 { streamed2.append(item) }
    XCTAssertEqual(streamed2.count, listedN)
  }
}
