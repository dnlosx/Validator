import XCTest
import Validator

final class ValidatorTests: XCTestCase {

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

        let mailtoRule = Rule.URL.mailto

        // Test valid mailto
        XCTAssertNoThrow(try "mailto://example@email.com".validate(mailtoRule))

        // Test invlalid mailto
        XCTAssertThrowsError(try "http://example@email.com".validate(mailtoRule))
        
        // Not Sugar syntax
        
        let ftpExpandedRule = Rule.URL(scheme: .ftp)
        
        // Test valid ftp
        XCTAssertNoThrow(try "ftp://localhost".validate(ftpExpandedRule))
    }

    func testNoEmpty() {
        let notEmptyRule = Rule.NotEmpty(fieldName: "First name")

        // Test valid strings.
        XCTAssertNoThrow(try "anything".validate(notEmptyRule))

        // Test invalid strings.
        XCTAssertThrowsError(try "".validate(notEmptyRule))
        XCTAssertThrowsError(try " ".validate(notEmptyRule)) // Space
        XCTAssertThrowsError(try "  ".validate(notEmptyRule)) // Tab
        XCTAssertThrowsError(try "\n".validate(notEmptyRule)) // Break line
        XCTAssertThrowsError(try "  \n".validate(notEmptyRule)) // Many empty characteres.
    }
    
    func testMultiplesRules() {
        let emailRule = Rule.Email()
        let notEmptyRule = Rule.NotEmpty(fieldName: "First name")
        
        let rules: [Validation] = [emailRule, notEmptyRule]
        
        // Test valid.
        XCTAssertNoThrow(try "email@example.com".validate(rules))
        
        // Test invalid a lest one.
        XCTAssertThrowsError(try "a".validate(rules))
        
        // Test if all of them are invalid.
        XCTAssertThrowsError(try "".validate(rules))
    }

    static var allTests = [
        ("testEmail", testEmail),
        ("testURL", testURL),
        ("testNoEmpty", testNoEmpty),
        ("testMultiplesRules", testMultiplesRules)
    ]
}
