//
//  PhotoService.swift
//  PhotoEase
//
//  Created by Khanh Nguyen on 8/2/25.
//

import Foundation
import Combine

class PhotoService {
    
    @Published var result: (photos: [PhotoModel]?, error: String?) = (nil, nil)
    private var photosSubscription: AnyCancellable?
    
    private let fetchDataPublisher: () -> AnyPublisher<[PhotoModel], Error>
    
    init(fetchDataPublisher: @escaping () -> AnyPublisher<[PhotoModel], Error> = {
        NetworkingManager.fetchData(from: Constants.photosURLString)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }) {
        self.fetchDataPublisher = fetchDataPublisher
    }
    
    func fetchPhotos() {
        photosSubscription = fetchDataPublisher()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.result = (nil, error.localizedDescription)
                default:
                    break
                }
            }, receiveValue: { [weak self] dataResponse in
                self?.result = (dataResponse, nil)
                self?.photosSubscription?.cancel()
            })
    }
}




