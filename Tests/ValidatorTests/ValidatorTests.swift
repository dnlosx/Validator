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
        // web
        let webRule = Rule.URL.web

        // Test valid URL
        XCTAssertNoThrow(try "http://example.com".validate(webRule))
        XCTAssertNoThrow(try "https://subdomain.domain.com.mx".validate(webRule))

        // Test invalid URL
        XCTAssertThrowsError(try "example".validate(webRule))
        XCTAssertThrowsError(try "ftp://domain.com".validate(webRule))
        
        // https
        let webSSLRule = Rule.URL.webSSL
        
        // Test valid https
        XCTAssertNoThrow(try "https://example.com".validate(webSSLRule))
        
        // Test invalid https
        XCTAssertThrowsError(try "http://example.com".validate(webSSLRule))
        
        let ftpRule = Rule.URL.ftp
        
        // Test valid ftp
        XCTAssertNoThrow(try "ftp://localhost".validate(ftpRule))
        
        // Test invalid ftp
        XCTAssertThrowsError(try "//localhost".validate(ftpRule))
    }

    func testNoEmpty() {
        let notEmptyRule = Rule.NotEmpty()

        // Test valid strings.
        XCTAssertNoThrow(try "anything".validate(notEmptyRule))

        // Test invalid strings.
        XCTAssertThrowsError(try "".validate(notEmptyRule))
        XCTAssertThrowsError(try " ".validate(notEmptyRule)) // Space
        XCTAssertThrowsError(try "  ".validate(notEmptyRule)) // Tab
        XCTAssertThrowsError(try "\n".validate(notEmptyRule)) // Break line

    }


    static var allTests = [
        ("testEmail", testEmail),
        ("testURL", testURL)
    ]
}
