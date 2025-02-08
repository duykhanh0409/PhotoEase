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
            List(viewModel.filteredPhotos) { photo in
                NavigationLink(destination: PhotoDetailScreen(viewModel: viewModel, photo: photo)) {
                    HStack {
                        AsyncImage(url: URL(string: photo.thumbnailUrl)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView().frame(width: 50, height: 50)
                            case .success(let image):
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            case .failure(_):
                                Image(systemName: "photo").resizable().scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        Text(photo.title)
                            .font(.body)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.toggleFavorite(for: photo)
                        }) {
                            Image(systemName: viewModel.isFavorite(photo) ? "star.fill" : "star")
                                .foregroundColor(viewModel.isFavorite(photo) ? .yellow : .gray)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            .navigationTitle("Photo List")
            .searchable(text: $viewModel.searchText, prompt: "Search Photos")
            .onAppear { viewModel.fetchPhotos() }
        }
    }
}


#Preview {
    PhotoHomeScreen()
}
