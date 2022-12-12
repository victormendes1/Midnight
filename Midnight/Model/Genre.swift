//
//  Genre.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/11/22.
//

import Foundation

struct Genres: Codable {
    var genres: [Genre] = []
}
    
struct Genre: Codable {
    var id: Int
    var name: String
    
    init(id: Int = .zero, name: String = "") {
        self.id = id
        self.name = name
    }
}
