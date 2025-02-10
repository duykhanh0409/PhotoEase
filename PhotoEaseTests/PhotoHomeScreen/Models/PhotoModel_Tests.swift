//
//  PhotoModelTests.swift
//  PhotoEase
//
//  Created by Khanh Nguyen on 9/2/25.
//

import XCTest
@testable import PhotoEase

class PhotoModel_Tests: XCTestCase {
    
    func testPhotoModelInitialization() {
        let photo = PhotoModel(
            albumId: 1,
            id: 101,
            title: "Test Photo",
            url: "https://via.placeholder.com/600/92c952",
            thumbnailUrl: "https://via.placeholder.com/150/92c952",
            favorite: true
        )
        
        XCTAssertEqual(photo.albumId, 1)
        XCTAssertEqual(photo.id, 101)
        XCTAssertEqual(photo.title, "Test Photo")
        XCTAssertEqual(photo.url, "https://dummyimage.com/600/92c952")
        XCTAssertEqual(photo.thumbnailUrl, "https://dummyimage.com/150/92c952")
        XCTAssertTrue(photo.favorite)
    }
    
    func testPhotoModelDefaultFavorite() {
        let photo = PhotoModel(
            albumId: 1,
            id: 102,
            title: "Test Photo 2",
            url: "https://via.placeholder.com/600/123456",
            thumbnailUrl: "https://via.placeholder.com/150/123456"
        )
        
        XCTAssertFalse(photo.favorite)
    }
}
