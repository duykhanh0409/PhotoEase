//
//  PhotoAsyncImage.swift
//  PhotoEase
//
//  Created by Khanh Nguyen on 8/2/25.
//

import SwiftUI

struct PhotoAsyncImage: View {
    let imageUrl: String
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            case .failure(_):
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            @unknown default:
                EmptyView()
            }
        }
    }
}

// ✅ Preview
#Preview {
    PhotoAsyncImage(imageUrl: "https://dummyimage.com/300/92c952", width: 100, height: 100, cornerRadius: 10)
}
