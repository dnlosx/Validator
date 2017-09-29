import XCTest
@testable import Validator

class ValidatorTests: XCTestCase {

    func testEmail() {
        let emailRule = Rule.Email()

        // Tests valid e-mail.
        XCTAssertNoThrow(try "example@example.com".validate(emailRule))
        XCTAssertNoThrow(try "abc_123@example.com.mx".validate(emailRule))
        XCTAssertNoThrow(try "a.bc@a.co".validate(emailRule))

        // Tests invalid e-mail.
        XCTAssertThrowsError(try "example".validate(emailRule))
        XCTAssertThrowsError(try "@".validate(emailRule))
        XCTAssertThrowsError(try "@example.com".validate(emailRule))
        XCTAssertThrowsError(try "example@".validate(emailRule))
    }

    func testURL() {
        let urlRule = Rule.URL()

        // Test valid URL
        XCTAssertNoThrow(try "http://example.com".validate(urlRule))
        XCTAssertNoThrow(try "https://subdomain.domain.com.mx".validate(urlRule))

        // Test invalid URL
        XCTAssertThrowsError(try "example".validate(urlRule))
    }


    static var allTests = [
        ("testEmail", testEmail),
    ]
}
