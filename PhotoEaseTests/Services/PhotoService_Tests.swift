//
//  PhotoServiceTests.swift
//  PhotoEase
//
//  Created by Khanh Nguyen on 9/2/25.
//

import XCTest
import Combine
@testable import PhotoEase
class PhotoService_Tests: XCTestCase {
    
    var photoService: PhotoService!
    var cancellables: Set<AnyCancellable> = []
    
    override func tearDown() {
        photoService = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testFetchPhotosSuccess() {
        photoService = PhotoService(fetchDataPublisher: MockPhotoService.fetchDataSuccess)
        
        let expectation = XCTestExpectation(description: "Fetch mock photos successfully")
        
        photoService.$result
            .dropFirst()
            .sink { result in
                XCTAssertNotNil(result.photos)
                XCTAssertNil(result.error)
                XCTAssertEqual(result.photos?.count, 2, "Should return 2 mock photos")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        photoService.fetchPhotos()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchPhotosFailure() {
       
        photoService = PhotoService(fetchDataPublisher: MockPhotoService.fetchDataFailure)
        
        let expectation = XCTestExpectation(description: "Fail to fetch photos")
        
        photoService.$result
            .dropFirst()
            .sink { result in
                XCTAssertNil(result.photos)
                XCTAssertNotNil(result.error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        photoService.fetchPhotos()
        
        wait(for: [expectation], timeout: 2.0)
    }
}

