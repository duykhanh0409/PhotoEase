//
//  MockPhotoService.swift
//  PhotoEase
//
//  Created by Khanh Nguyen on 9/2/25.
//
@testable import PhotoEase
import Combine
import Foundation

class MockPhotoService {
    
    static func fetchDataSuccess() -> AnyPublisher<[PhotoModel], Error> {
        let mockPhotos = [
            PhotoModel(albumId: 1, id: 1, title: "Mock Photo 1",
                       url: "https://dummyimage.com/600/92c952",
                       thumbnailUrl: "https://dummyimage.com/150/92c952"),
            PhotoModel(albumId: 1, id: 2, title: "Mock Photo 2",
                       url: "https://dummyimage.com/600/771796",
                       thumbnailUrl: "https://dummyimage.com/150/771796")
        ]
        
        return Just(mockPhotos)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    static func fetchDataFailure() -> AnyPublisher<[PhotoModel], Error> {
        return Fail(error: URLError(.badServerResponse))
            .eraseToAnyPublisher()
    }
}
