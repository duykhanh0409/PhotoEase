//
//  PhotoHomeViewModels.swift
//  PhotoEaseTests
//
//  Created by Khanh Nguyen on 9/2/25.
//

import XCTest
import Combine
@testable import PhotoEase
class PhotoHomeViewModel_Tests: XCTestCase {
    
    var viewModel: PhotoViewModel!
    var photoService: PhotoService!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        viewModel = PhotoViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testFetchPhotos_Success() {
        viewModel = PhotoViewModel()
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
    
    
    func testSearchFiltering() {
        viewModel.photos = [
            PhotoModel(albumId: 1, id: 1, title: "Sunset",
                       url: "https://dummyimage.com/600/aaa",
                       thumbnailUrl: "https://dummyimage.com/150/aaa"),
            PhotoModel(albumId: 1, id: 2, title: "Ocean",
                       url: "https://dummyimage.com/600/bbb",
                       thumbnailUrl: "https://dummyimage.com/150/bbb")
        ]
        
        viewModel.searchText = "Sunset"
        
        XCTAssertEqual(viewModel.filteredPhotos.count, 1)
        XCTAssertEqual(viewModel.filteredPhotos.first?.title, "Sunset")
    }
    
    func testToggleFavorite() {

        let photo = PhotoModel(albumId: 1, id: 1, title: "Favorite Test",
                               url: "https://dummyimage.com/600/ccc",
                               thumbnailUrl: "https://dummyimage.com/150/ccc")
        viewModel.photos = [photo]
        
        viewModel.toggleFavorite(for: photo)
        
        XCTAssertTrue(viewModel.isFavorite(photo))
        
        viewModel.toggleFavorite(for: photo)
        
        XCTAssertFalse(viewModel.isFavorite(photo))
    }
    
    func testFavoriteFilter() {
        let photo1 = PhotoModel(albumId: 1, id: 1, title: "Photo 1",
                                url: "https://dummyimage.com/600/ddd",
                                thumbnailUrl: "https://dummyimage.com/150/ddd", favorite: true)
        let photo2 = PhotoModel(albumId: 1, id: 2, title: "Photo 2",
                                url: "https://dummyimage.com/600/eee",
                                thumbnailUrl: "https://dummyimage.com/150/eee", favorite: false)
        
        viewModel.photos = [photo1, photo2]
        
        viewModel.toggleFavoriteFilter()
        
        XCTAssertEqual(viewModel.filteredPhotos.count, 1)
        XCTAssertTrue(viewModel.filteredPhotos.first?.favorite ?? false)
    }
}

