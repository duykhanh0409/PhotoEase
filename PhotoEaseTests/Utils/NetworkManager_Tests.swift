//
//  NetworkManagerTests.swift
//  PhotoEaseTests
//
//  Created by Khanh Nguyen on 9/2/25.
//

import XCTest
import Combine
@testable import PhotoEase

class NetworkingManager_Tests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    
    func testFetchData_Success() {
        let url = "https://jsonplaceholder.typicode.com/photos"
        let expectation = XCTestExpectation(description: "Fetch successful data from API")
        
        NetworkingManager.fetchData(from: url)
            .sink(receiveCompletion: { completion in
                let errorMessage = NetworkingManager.handleCompletion(completion)
                XCTAssertNil(errorMessage, "No error should be returned on success")
            }, receiveValue: { data in
                XCTAssertFalse(data.isEmpty, " Data should not be empty")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchData_InvalidURL() {
        let url = "invalid_url"
        let expectation = XCTestExpectation(description: "Invalid URL should return an error")
        
        NetworkingManager.fetchData(from: url)
            .sink(receiveCompletion: { completion in
                let errorMessage = NetworkingManager.handleCompletion(completion)
                XCTAssertNotNil(errorMessage, "Expect error message for invalid URL")
                expectation.fulfill()
            }, receiveValue: { _ in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchData_BadResponse() {
        let url = "https://jsonplaceholder.typicode.com/invalidEndpoint"
        let expectation = XCTestExpectation(description: "Bad response should return an error")
        
        NetworkingManager.fetchData(from: url)
            .sink(receiveCompletion: { completion in
                let errorMessage = NetworkingManager.handleCompletion(completion)
                XCTAssertNotNil(errorMessage, "Expect an error message for bad response")
                expectation.fulfill()
            }, receiveValue: { _ in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
}





