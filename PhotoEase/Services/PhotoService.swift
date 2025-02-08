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
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] dataResponse in
                self?.photos = dataResponse
                self?.photosSubscription?.cancel()
            })
    }
}


