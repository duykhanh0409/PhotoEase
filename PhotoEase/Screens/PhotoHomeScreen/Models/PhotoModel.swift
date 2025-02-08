//
//  PhotoModels.swift
//  PhotoEase
//
//  Created by Khanh Nguyen on 8/2/25.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    var favorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case albumId, id, title, url, thumbnailUrl
    }

    init(albumId: Int, id: Int, title: String, url: String, thumbnailUrl: String, favorite: Bool = false) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url.replacingOccurrences(of: "via.placeholder.com", with: "dummyimage.com")
        self.thumbnailUrl = thumbnailUrl.replacingOccurrences(of: "via.placeholder.com", with: "dummyimage.com")
        self.favorite = favorite
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.albumId = try container.decode(Int.self, forKey: .albumId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
            .replacingOccurrences(of: "via.placeholder.com", with: "dummyimage.com")
        self.thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
            .replacingOccurrences(of: "via.placeholder.com", with: "dummyimage.com")
        self.favorite = false
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(albumId, forKey: .albumId)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(url, forKey: .url)
        try container.encode(thumbnailUrl, forKey: .thumbnailUrl)
    }
}
