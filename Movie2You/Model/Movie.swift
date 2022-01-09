//
//  Movie.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation

// MARK: - Model used to show on main screen
struct Movies {
    var mainMovie: Movie?
    var movies: [Movie]?
    let backdropPath: String
    var genres: Genres?
    let genreId: [Int]?
    let id: Int
    let originalTitle: String
    let releaseDate: String
    let posterPath: String
    let popularity: Double
    let voteCount: Int
}

extension Movies {
    func posterURL() -> URL? {
        URL(string: NetworkConstants.posterBaseURL + posterPath)
    }
    
    func backdropURL() -> URL? {
        URL(string: NetworkConstants.backdropBaseURL + backdropPath)
    }
    
    func getGenres() -> String {
        self.genreId?.compactMap { number -> String in
            self.genres?.genres.filter({ $0.id == number }).map({ $0.name}).joined() ?? ""
        }.filter({ $0 != "" }).prefix(3).sorted(by: <).joined(separator: ", ") ?? ""
    }
    
    var releaseYear: Int {
        get {
            return Int(releaseDate.split(separator: "-")[0]) ?? 0
        }
    }
}

// MARK: - Model used to download the movie from the network
struct Movie: Codable {
    var backdropPath: String?
    var genres: [Genre]?
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

struct SimilarMovies: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
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
