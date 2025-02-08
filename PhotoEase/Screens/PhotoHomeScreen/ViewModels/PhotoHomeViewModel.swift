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
    @Published var searchText: String = ""
    @Published var filteredPhotos: [PhotoModel] = []
    @Published var favorites: [Int: Bool] = [:]
    
    private let photoService = PhotoService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
       
        photoService.$photos
            .sink { [weak self] (returnedPhotos) in
                guard let photos = returnedPhotos else { return }
                self?.photos = photos
                self?.filteredPhotos = photos
            }
            .store(in: &cancellables)
        
     
        $searchText
            .combineLatest($photos)
            .map { (text, allPhotos) -> [PhotoModel] in
                guard !text.isEmpty else {
                    return allPhotos
                }
                return allPhotos.filter {
                    $0.title.localizedCaseInsensitiveContains(text)
                }
            }
            .assign(to: \.filteredPhotos, on: self)
            .store(in: &cancellables)
    }
    
    func fetchPhotos() {
        photoService.fetchPhotos()
    }
    
    func toggleFavorite(for photo: PhotoModel) {
        favorites[photo.id]?.toggle()
        if favorites[photo.id] == nil {
            favorites[photo.id] = true
        }
    }
    
    func isFavorite(_ photo: PhotoModel) -> Bool {
        favorites[photo.id] ?? false
    }
}


