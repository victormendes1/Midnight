//
//  Image.swift
//  Midnight
//
//  Created by Victor Mendes on 26/12/22.
//

import UIKit

struct Posters: Codable {
    let id: Int
    let backdrops, posters: [Poster]
}

// MARK: - Image
struct Poster: Codable {
    let filePath: String
    let width, height: Int
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
        case height
        case width
    }
}
