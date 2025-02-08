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
    @Published var showFavoritesOnly = false
    @Published var filteredPhotos: [PhotoModel] = []
    @Published var isLoading = false
    
    private let photoService = PhotoService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        photoService.$photos
            .sink { [weak self] (returnedPhotos) in
                self?.isLoading = false
                guard let photos = returnedPhotos else { return }
                self?.photos = photos
                self?.applyFilters()
            }
            .store(in: &cancellables)
        
        $searchText
            .combineLatest($photos)
            .map { (text, allPhotos) -> [PhotoModel] in
                if text.isEmpty {
                    return allPhotos
                }
                return allPhotos.filter { $0.title.localizedCaseInsensitiveContains(text) }
            }
            .assign(to: \.filteredPhotos, on: self)
            .store(in: &cancellables)
    }
    
    func fetchPhotos() {
        isLoading = true
        photoService.fetchPhotos()
    }
    
    func toggleFavorite(for photo: PhotoModel) {
        if let index = photos.firstIndex(where: { $0.id == photo.id }) {
            photos[index].favorite.toggle()
            applyFilters()
        }
    }
    
    func isFavorite(_ photo: PhotoModel) -> Bool {
        return photos.first(where: { $0.id == photo.id })?.favorite ?? false
    }

    func toggleFavoriteFilter() {
        if searchText.isEmpty {
            showFavoritesOnly.toggle()
            applyFilters()
        }
    }
    
    private func applyFilters() {
        filteredPhotos = photos.filter { photo in
            (!showFavoritesOnly || photo.favorite)
        }
    }
}
