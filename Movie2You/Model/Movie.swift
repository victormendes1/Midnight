//
//  Movie.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation

struct Movie: Codable {
    let backdropPath: String
    let genres: [Genre]?
    let genreId: [Int]?
    let id: Int
    let originalTitle: String
    let releaseDate: String
    let posterPath: String
    let popularity: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id
        case genreId = "genre_ids"
        case originalTitle = "original_title"
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteCount = "vote_count"
    }
}

extension Movie {
    func posterURL() -> URL? {
        URL(string: NetworkConstants.posterBaseURL + posterPath)
    }
    
    func  backdropURL() -> URL? {
        URL(string: NetworkConstants.backdropBaseURL + backdropPath)
    }
}
// MARK: - Genre
struct Genres: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct SimilarMovies: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
