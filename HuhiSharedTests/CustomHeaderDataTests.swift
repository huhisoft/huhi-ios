// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import XCTest
@testable import HuhiShared
import SwiftyJSON

class CustomHeaderDataTest: XCTestCase {
    
    //Valid Json from server.
    var expectedJSON = """
[{"domains":["example1.com","api.example1.com"],"headers":{"X-Huhi-Partner":"example"},"cookieNames":[],"expiration":31536000000},{"domains":["testing.com","testing1.com"],"headers":{"X-Huhi-Partner":"QA"},"cookieNames":[],"expiration":31536000000},{"domains":["xyz.com","abc.com","pqr.com"],"headers":{"X-Huhi-Partner":"combinations"},"cookieNames":[],"expiration":31536000000},{"domains":["cookies.co.au"],"headers":{"X-Huhi-Partner":"oreo"},"cookieNames":[],"expiration":31536000000}]
"""
    
    //Invalid partner key
    var maliciousJSON = """
[{"domains":["example1.com","api.example1.com"],"headers":{"Not-X-Huhi-Partner":"example"},"cookieNames":[],"expiration":31536000000},{"domains":["testing.com","testing1.com"],"headers":{"Not-X-Huhi-Partner":"QA"},"cookieNames":[],"expiration":31536000000},{"domains":["xyz.com","abc.com","pqr.com"],"headers":{"Not-X-Huhi-Partner":"combinations"},"cookieNames":[],"expiration":31536000000},{"domains":["cookies.co.au"],"headers":{"Not-X-Huhi-Partner":"oreo"},"cookieNames":[],"expiration":31536000000}]
"""
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectedHeaders = getCustomHeader(for: expectedJSON)
        let maliciousHeaders = getCustomHeader(for: maliciousJSON)
        //Tests for non empty array of headers from valid json
        XCTAssertFalse(expectedHeaders.isEmpty)
        //Tests the non empty array for the correct key
        XCTAssertFalse(expectedHeaders.contains(where: {$0.headerField != CustomHeaderData.huhiPartnerKey}))
        //Test for empty array of headers from malicious json
        XCTAssertTrue(maliciousHeaders.isEmpty)
    }
    
    func getCustomHeader(for jsonString: String) -> [CustomHeaderData] {
        let json = JSON(parseJSON: jsonString)
        return CustomHeaderData.customHeaders(from: json)
    }
}

