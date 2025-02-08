//
//  PhotoDetailScreen.swift
//  PhotoEase
//
//  Created by Khanh Nguyen on 8/2/25.
//

import SwiftUI

struct PhotoDetailScreen: View {
    @ObservedObject var viewModel: PhotoViewModel
    let photo: PhotoModel
    
    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: photo.url)) { phase in
                switch phase {
                case .empty:
                    ProgressView().frame(width: 300, height: 300)
                case .success(let image):
                    image.resizable().scaledToFit().frame(maxWidth: 300, maxHeight: 300)
                case .failure(_):
                    Image(systemName: "photo").resizable().scaledToFit().frame(width: 300, height: 300)
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(photo.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Photo Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: {
                viewModel.toggleFavorite(for: photo)
            }) {
                Image(systemName: viewModel.isFavorite(photo) ? "star.fill" : "star")
                    .foregroundColor(viewModel.isFavorite(photo) ? .yellow : .gray)
            }
        }
    }
}
