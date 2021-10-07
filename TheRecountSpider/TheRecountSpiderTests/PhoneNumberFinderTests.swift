//
//  PhoneNumberFinderTests.swift
//  TheRecountSpiderTests
//
//

import XCTest

class PhoneNumberFinderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParseSimplePhoneNumbers() throws {
        // =========== Given
        let text = "404-555-1212"
        
        // =========== When
        let numbers = PhoneNumberFinder.find(text: text)
        
        // =========== Then
        XCTAssertTrue(numbers.contains("404-555-1212"))
    }

    func testParseSimplePageWithPhoneNumbers() throws {
        // =========== Given
        let text = """
        <html>
          <body>
            <p>404-555-1212</p>
          </body>
        </html>
        """
        
        // =========== When
        let numbers = PhoneNumberFinder.find(text: text)
        
        // =========== Then
        XCTAssertFalse(numbers.contains("404-555-1212"))
    }

}
