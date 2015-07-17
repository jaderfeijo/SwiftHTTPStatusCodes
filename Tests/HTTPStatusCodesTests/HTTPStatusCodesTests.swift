//
//  HTTPStatusCodesTests.swift
//  HTTPStatusCodesTests
//
//  Created by Richard Hodgkins on 22/02/2015.
//  Copyright (c) 2015 Rich H. All rights reserved.
//

import Foundation
import XCTest

@testable import HTTPStatusCodes

private func response(statusCode: Int) -> NSHTTPURLResponse {
    return NSHTTPURLResponse(URL: NSURL(string: "http://www.google.com")!, statusCode: statusCode, HTTPVersion: nil, headerFields: nil)!
}
private func response(statusCode: HTTPStatusCode) -> NSHTTPURLResponse {
    return NSHTTPURLResponse(URL: NSURL(string: "http://www.google.com")!, statusCode: statusCode, HTTPVersion: nil, headerFields: nil)!
}

class HTTPStatusCodesTests: XCTestCase {
    
    func testNSHTTPURLResponseInit() {
        XCTAssertEqual(response(.Continue).statusCode, 100, "Incorrect status code")
        XCTAssertEqual(response(.OK).statusCode, 200, "Incorrect status code")
        XCTAssertEqual(response(.MultipleChoices).statusCode, 300, "Incorrect status code")
        XCTAssertEqual(response(.BadRequest).statusCode, 400, "Incorrect status code")
        XCTAssertEqual(response(.InternalServerError).statusCode, 500, "Incorrect status code")
    }
    
    func testComputedStatusCodeValueProperty() {
        XCTAssertEqual(response(100).statusCodeValue!, HTTPStatusCode.Continue, "Incorrect status code")
        XCTAssertEqual(response(200).statusCodeValue!, HTTPStatusCode.OK, "Incorrect status code")
        XCTAssertEqual(response(300).statusCodeValue!, HTTPStatusCode.MultipleChoices, "Incorrect status code")
        XCTAssertEqual(response(400).statusCodeValue!, HTTPStatusCode.BadRequest, "Incorrect status code")
        XCTAssertEqual(response(500).statusCodeValue!, HTTPStatusCode.InternalServerError, "Incorrect status code")
    }
    
    func testHTTPStatusCodeInit() {
        XCTAssertEqual(HTTPStatusCode(HTTPResponse: response(100))!, HTTPStatusCode.Continue, "Incorrect status code")
        XCTAssertEqual(HTTPStatusCode(HTTPResponse: response(200))!, HTTPStatusCode.OK, "Incorrect status code")
        XCTAssertEqual(HTTPStatusCode(HTTPResponse: response(300))!, HTTPStatusCode.MultipleChoices, "Incorrect status code")
        XCTAssertEqual(HTTPStatusCode(HTTPResponse: response(400))!, HTTPStatusCode.BadRequest, "Incorrect status code")
        XCTAssertEqual(HTTPStatusCode(HTTPResponse: response(500))!, HTTPStatusCode.InternalServerError, "Incorrect status code")
    }
    
    func testBooleanRangeChecks() {
        for i in 100...199 {
            if let statusCode = HTTPStatusCode(rawValue: i) {
                XCTAssertTrue(statusCode.isInformational, "Should be informational status code")
            }
        }
        for i in 200...299 {
            if let statusCode = HTTPStatusCode(rawValue: i) {
                XCTAssertTrue(statusCode.isSuccess, "Should be success status code")
            }
        }
        for i in 300...399 {
            if let statusCode = HTTPStatusCode(rawValue: i) {
                XCTAssertTrue(statusCode.isRedirection, "Should be redirection status code")
            }
        }
        for i in 400...499 {
            if let statusCode = HTTPStatusCode(rawValue: i) {
                XCTAssertTrue(statusCode.isClientError, "Should be client error status code")
            }
        }
        for i in 500...599 {
            if let statusCode = HTTPStatusCode(rawValue: i) {
                XCTAssertTrue(statusCode.isServerError, "Should be server error status code")
            }
        }
    }
    
    func testReasonPhrase() {
        XCTAssertEqual(HTTPStatusCode.Continue.localizedReasonPhrase, NSHTTPURLResponse.localizedStringForStatusCode(HTTPStatusCode.Continue.rawValue))
        
        XCTAssertEqual(HTTPStatusCode.OK.localizedReasonPhrase, NSHTTPURLResponse.localizedStringForStatusCode(HTTPStatusCode.OK.rawValue))
        
        XCTAssertEqual(HTTPStatusCode.MultipleChoices.localizedReasonPhrase, NSHTTPURLResponse.localizedStringForStatusCode(HTTPStatusCode.MultipleChoices.rawValue))
        
        XCTAssertEqual(HTTPStatusCode.BadRequest.localizedReasonPhrase, NSHTTPURLResponse.localizedStringForStatusCode(HTTPStatusCode.BadRequest.rawValue))
        
        XCTAssertEqual(HTTPStatusCode.InternalServerError.localizedReasonPhrase, NSHTTPURLResponse.localizedStringForStatusCode(HTTPStatusCode.InternalServerError.rawValue))
    }
    
    func testDescription() {
        XCTAssertEqual(String(HTTPStatusCode.Continue), "\(HTTPStatusCode.Continue.rawValue) - \(HTTPStatusCode.Continue.localizedReasonPhrase)")
        
        XCTAssertEqual(String(HTTPStatusCode.OK), "\(HTTPStatusCode.OK.rawValue) - \(HTTPStatusCode.OK.localizedReasonPhrase)")
        
        XCTAssertEqual(String(HTTPStatusCode.MultipleChoices), "\(HTTPStatusCode.MultipleChoices.rawValue) - \(HTTPStatusCode.MultipleChoices.localizedReasonPhrase)")
        
        XCTAssertEqual(String(HTTPStatusCode.BadRequest), "\(HTTPStatusCode.BadRequest.rawValue) - \(HTTPStatusCode.BadRequest.localizedReasonPhrase)")
        
        XCTAssertEqual(String(HTTPStatusCode.InternalServerError), "\(HTTPStatusCode.InternalServerError.rawValue) - \(HTTPStatusCode.InternalServerError.localizedReasonPhrase)")
    }
    
    func testDebugDescription() {
        XCTAssertEqual(String(reflecting: HTTPStatusCode.Continue), "HTTPStatusCode:\(HTTPStatusCode.Continue.rawValue) - \(HTTPStatusCode.Continue.localizedReasonPhrase)")
        
        XCTAssertEqual(String(reflecting: HTTPStatusCode.OK), "HTTPStatusCode:\(HTTPStatusCode.OK.rawValue) - \(HTTPStatusCode.OK.localizedReasonPhrase)")
        
        XCTAssertEqual(String(reflecting: HTTPStatusCode.MultipleChoices), "HTTPStatusCode:\(HTTPStatusCode.MultipleChoices.rawValue) - \(HTTPStatusCode.MultipleChoices.localizedReasonPhrase)")
        
        XCTAssertEqual(String(reflecting: HTTPStatusCode.BadRequest), "HTTPStatusCode:\(HTTPStatusCode.BadRequest.rawValue) - \(HTTPStatusCode.BadRequest.localizedReasonPhrase)")
        
        XCTAssertEqual(String(reflecting: HTTPStatusCode.InternalServerError), "HTTPStatusCode:\(HTTPStatusCode.InternalServerError.rawValue) - \(HTTPStatusCode.InternalServerError.localizedReasonPhrase)")
    }
    
    func testBadStatusCodes() {
        XCTAssertTrue(HTTPStatusCode(rawValue: 1000) == nil)
        XCTAssertTrue(HTTPStatusCode(HTTPResponse: nil) == nil)
        XCTAssertTrue(HTTPStatusCode(HTTPResponse: response(1000)) == nil)
    }
}
