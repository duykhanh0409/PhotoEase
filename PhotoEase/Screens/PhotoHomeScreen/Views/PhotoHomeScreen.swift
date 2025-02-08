//
//  PhotoHomeScreen.swift
//  PhotoEase
//
//  Created by Khanh Nguyen on 8/2/25.
//

import SwiftUI

struct PhotoHomeScreen: View {
    
    @StateObject private var viewModel = PhotoViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading photos...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    List(viewModel.filteredPhotos) { photo in
                        NavigationLink(destination: PhotoDetailScreen(viewModel: viewModel, photo: photo)) {
                            PhotoItem(photo)
                        }
                    }
                    .navigationTitle("Photo List")
                    .listStyle(.plain)
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search Photos")
            .onAppear {
                if viewModel.photos.isEmpty {
                    viewModel.fetchPhotos()
                }
            }
            .toolbar {
                leadingNavItems()
                trailingNavItems()
            }
        }
    }
}

extension PhotoHomeScreen {
    private func leadingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                Button(action: {
                 
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.blue)
                }
                
                Text("Photos App")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
    }
    
    private func trailingNavItems() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            if viewModel.searchText.isEmpty {
                Button(action: {
                    viewModel.toggleFavoriteFilter()
                }) {
                    Image(systemName: viewModel.showFavoritesOnly ? "star.fill" : "star")
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
    private func PhotoItem(_ photo: PhotoModel) -> some View {
        HStack {
            PhotoAsyncImage(
                imageUrl: photo.thumbnailUrl,
                width: 50,
                height: 50,
                cornerRadius: 25
            )
            .padding(.leading)
            
            Text(photo.title)
                .font(.body)
                .lineLimit(2)
            
            Spacer()
            
            Button(action: {
                viewModel.toggleFavorite(for: photo)
            }) {
                Image(systemName: viewModel.isFavorite(photo) ? "star.fill" : "star")
                    .foregroundColor(.black)
                    .padding(.trailing)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

#Preview {
    PhotoHomeScreen()
}
