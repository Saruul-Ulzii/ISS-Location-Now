//
//  ISS_Location_NowTests.swift
//  ISS Location NowTests
//
//  Created by Saruululzii on 9/6/22.
//

import XCTest
@testable import ISS_Location_Now

class ConstantsTests: XCTestCase {
    func testApiUrlCheck() throws {
        XCTAssertEqual(Constants.API_URL, "http://api.open-notify.org/iss-now.json", "API URL is different! Please correct it!")
    }
    
    func testCustomAnnotationImageCheck() throws {
        XCTAssertEqual(Constants.annotationCustomImageName, "pin_satellite", "Custom annotation name is invalid! Please correct it!")
    }
    
    func testApiFetchIntervalIsValid() throws {
        XCTAssertGreaterThanOrEqual(Constants.fetchInterval, 1, "Fetch interval value is invalid! Please check the value!")
    }
    
    func testApiFetchIntervalDefaultValueCheck() throws {
        XCTAssertEqual(Constants.fetchInterval, 3, "Fetch interval value is not equals to 3! Please check!")
    }
    
    func testApiLatitudinalMetersNotProperValueCheck() throws {
        XCTAssertGreaterThanOrEqual(Constants.latitudinalMeters, 100000, "Latitude meter is too small, use: [100000, 500000]")
        XCTAssertLessThanOrEqual(Constants.latitudinalMeters, 500000, "Latitude meter is too big, use: [100000, 500000]")
    }
    
    func testApiLongitudinalMetersNotProperValueCheck() throws {
        XCTAssertGreaterThanOrEqual(Constants.latitudinalMeters, 100000, "Longitude meter is too small, use: [100000, 500000]")
        XCTAssertLessThanOrEqual(Constants.latitudinalMeters, 500000, "Longitude meter is too big, use: [100000, 500000]")
    }
}
