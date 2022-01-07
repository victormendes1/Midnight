//
//  MoviesModel.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation

struct Movie: Codable {
    let backdropPath: String
    let genres: [Genre]
    let id: Int
    let originalTitle: String
    let releaseDate: String
    let posterPath: String
    let popularity: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id
        case originalTitle = "original_title"
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
