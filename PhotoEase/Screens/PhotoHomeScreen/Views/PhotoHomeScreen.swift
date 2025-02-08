//
//  PhotoHomeScreen.swift
//  PhotoEase
//
//  Created by Khanh Nguyen on 8/2/25.
//

import SwiftUI

struct Photo: Identifiable {
    let id: Int
    let title: String
    let thumbnailUrl: String
}

struct PhotoHomeScreen: View {
    @StateObject private var viewModel = PhotoViewModel()
    @State private var searchText = ""


    var body: some View {
        NavigationStack {
            List(viewModel.photos) { photo in
                    HStack {
                        AsyncImage(url: URL(string: photo.thumbnailUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                        }

                        Text(photo.title)
                            .font(.body)
                            .lineLimit(1)
                            .padding(.leading, 8)
                        
                        Spacer()
                        
                        Image(systemName: "star")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
            
            }
            .navigationTitle("Photo List")
            .searchable(text: $searchText, prompt: "Search Photos")
            .onAppear { viewModel.fetchPhotos() }
        }
    }
}



struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoHomeScreen()
    }
}
