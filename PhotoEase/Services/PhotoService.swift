//
//  PhotoService.swift
//  PhotoEase
//
//  Created by Khanh Nguyen on 8/2/25.
//

import Foundation
import Combine

class PhotoService {
    
    @Published var photos: [PhotoModel]? = nil
    private var photosSubscription: AnyCancellable?
    
    func fetchPhotos() {
        let url = Constants.photosURLString
        
        photosSubscription = NetworkingManager.fetchData(from: url)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .map { photos in

                return photos.map { photo in
                    PhotoModel(
                        albumId: photo.albumId,
                        id: photo.id,
                        title: photo.title,
                        url: photo.url.replacingOccurrences(of: "via.placeholder.com", with: "dummyimage.com"),
                        thumbnailUrl: photo.thumbnailUrl.replacingOccurrences(of: "via.placeholder.com", with: "dummyimage.com")
                    )
                }
            }
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] modifiedPhotos in
                self?.photos = modifiedPhotos
                self?.photosSubscription?.cancel()
            })
    }
}


