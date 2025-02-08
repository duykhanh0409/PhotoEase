//
//  PhotoDetailScreen.swift
//  PhotoEase
//
//  Created by Khanh Nguyen on 8/2/25.
//

import SwiftUI

struct PhotoDetailScreen: View {
    @ObservedObject var viewModel: PhotoViewModel
    @State private var showAlert = false
    let photo: PhotoModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Photo Detail")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            PhotoAsyncImage(
                imageUrl: photo.url,
                width: 300,
                height: 300,
                cornerRadius: 0
            )
            Spacer()
            Text("Title: \(photo.title)")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            trailingNavItems()
        }
        .alert("Are you sure to dislike this photo?", isPresented: $showAlert) {
            Button("Cancel", role: .cancel) { }
            
            Button("Sure", role: .destructive) {
                viewModel.toggleFavorite(for: photo)
            }
        }
    }
}


extension PhotoDetailScreen {
    private func trailingNavItems()-> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button(action: {
                if viewModel.isFavorite(photo) {
                    showAlert = true
                } else {
                    viewModel.toggleFavorite(for: photo)
                }
            }) {
                Image(systemName: viewModel.isFavorite(photo) ? "star.fill" : "star")
                    .foregroundColor(viewModel.isFavorite(photo) ? .blue : .gray)
            }
        }
        
    }
}
