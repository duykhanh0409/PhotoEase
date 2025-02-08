//
//  PhotoHomeViewModel.swift
//  PhotoEase
//
//  Created by Khanh Nguyen on 8/2/25.
//

import Foundation
import Combine

class PhotoViewModel: ObservableObject {
    
    @Published var photos: [PhotoModel] = []
    
    private let photoService = PhotoService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        photoService.$photos
            .sink { [weak self] (returnedPhotos) in
                guard let photos = returnedPhotos else { return }
                print("list photos: \(photos) ")
                self?.photos = photos
            }
            .store(in: &cancellables)
      
    }
    
    func fetchPhotos() {
        photoService.fetchPhotos()
    }
    
}


