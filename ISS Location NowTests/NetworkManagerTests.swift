//
//  NetworkManagerTests.swift
//  ISS Location NowTests
//
//  Created by Saruululzii on 9/6/22.
//

import XCTest
@testable import ISS_Location_Now

class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager = NetworkManager()
    
    func testDataRequestWithValidURL() throws {
        let expectation = XCTestExpectation(description: #function)
        var issPositions: [ISSPosition] = []
        
        networkManager.get(Constants.API_URL, parameters: nil)
        networkManager.successBlock = { data in
            if let data = data {
                if let coordinates = try? JSONDecoder().decode(ISSPosition.self, from: data) {
                    issPositions.append(coordinates)
                    expectation.fulfill()
                }
            }
        }
        networkManager.failureBlock = { error in
            if let error = error as? NSError {
                XCTFail("Error code: \(error.code), Description: \(error.localizedDescription)")
            }
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssert(!issPositions.isEmpty, "Position array is empty! It must be have one position!")
    }
    
    func testDataRequestWithInvalidURL() throws {
        let expectation = XCTestExpectation(description: #function)
        let issPositions: [ISSPosition] = []
        
        networkManager.get("INVALID_URL_FOR_FAILURE_CASE", parameters: nil)
        networkManager.successBlock = { _ in
            XCTFail("This request must be invalid!")
        }
        networkManager.failureBlock = { error in
            if let error = error as? NSError {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssert(issPositions.isEmpty, "This request must be invalid!")
    }
    
    func testDataFetchDuration() throws {
        let expectation = XCTestExpectation(description: #function)
        var issPositions: [ISSPosition] = []
        
        networkManager.get(Constants.API_URL, parameters: nil)
        networkManager.successBlock = { data in
            if let data = data {
                if let coordinates = try? JSONDecoder().decode(ISSPosition.self, from: data) {
                    issPositions.append(coordinates)
                    expectation.fulfill()
                }
            }
        }
        networkManager.failureBlock = { error in
            if let error = error as? NSError {
                XCTFail("Error code: \(error.code), Description: \(error.localizedDescription)")
            }
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssert(!issPositions.isEmpty, "Position array is empty! It must be have one position!")
    }
}
