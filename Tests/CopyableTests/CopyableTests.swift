import XCTest
@testable import Copyable

final class CopyableTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Copyable().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
