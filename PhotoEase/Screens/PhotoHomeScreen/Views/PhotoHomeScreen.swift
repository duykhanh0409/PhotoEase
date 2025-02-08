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
    @State private var searchText = ""
    private let photos = [
        Photo(id: 1, title: "accusamus beatae ad facilis cum similique qui sunt", thumbnailUrl: "https://via.placeholder.com/150/92c952"),
        Photo(id: 2, title: "reprehenderit est deserunt velit ipsam", thumbnailUrl: "https://via.placeholder.com/150/771796"),
        Photo(id: 3, title: "officia porro iure quia iusto qui ipsa ut modi", thumbnailUrl: "https://via.placeholder.com/150/24f355"),
        Photo(id: 4, title: "culpa odio esse rerum omnis laboriosam voluptate repudiandae", thumbnailUrl: "https://via.placeholder.com/150/d32776"),
        Photo(id: 5, title: "natus nisi omnis corporis facere molestiae rerum in", thumbnailUrl: "https://via.placeholder.com/150/f66b97"),
        Photo(id: 6, title: "accusamus ea aliquid et amet sequi nemo", thumbnailUrl: "https://via.placeholder.com/150/56a8c2"),
        Photo(id: 7, title: "officia delectus consequatur vero aut veniam explicabo molestias", thumbnailUrl: "https://via.placeholder.com/150/b0f7cc")
    ]


    var body: some View {
        NavigationStack {
            List(photos) { photo in
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
 
        }
    }
}



struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoHomeScreen()
    }
}
