//
//  Movie.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation

// MARK: - Model used to show on main screen
struct Movies {
    var mainMovie: Movie
    var movies: [Movie]
    var backdropPath: String
    var genres: Genres
    let genreId: [Int]
    let id: Int
    let originalTitle: String
    let releaseDate: String
    let posterPath: String
    let popularity: Double
    let voteCount: Int
    
    init (mainMovie: Movie = Movie(), movies: [Movie] = [], backdropPath: String = "", genres: Genres = Genres(), genreId: [Int] = [], id: Int = .zero, originalTitle: String = "", releaseDate: String = "", posterPath: String = "", popularity: Double = .zero, voteCount: Int = .zero) {
        self.mainMovie = mainMovie
        self.movies = movies
        self.backdropPath = backdropPath
        self.genres = genres
        self.genreId = genreId
        self.id = id
        self.originalTitle = originalTitle
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.popularity = popularity
        self.voteCount = voteCount
    }
    
    
    
    
}

extension Movies {
    func posterURL() -> URL? {
        URL(string: NetworkConstants.posterBaseURL + posterPath)
    }
    
    func getGenres() -> String {
        self.genreId.compactMap { number -> String in
            self.genres.genres.filter({ $0.id == number }).map({ $0.name}).joined()
        }.filter({ $0 != "" }).prefix(2).sorted(by: <).joined(separator: ", ")
    }
    
    var releaseYear: String {
        releaseDate.split(separator: "-").map({ String($0) }).first ?? ""
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
    
    init(backdropPath: String = "", genres: [Genre] = [], genreId: [Int] = [], id: Int = .zero, originalTitle: String = "", releaseDate: String = "", posterPath: String = "", popularity: Double = .zero, voteCount: Int = .zero) {
        self.backdropPath = backdropPath
        self.genres = genres
        self.genreId = genreId
        self.id = id
        self.originalTitle = originalTitle
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.popularity = popularity
        self.voteCount = voteCount
    }
    
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
// MARK: - Genre
struct SimilarMovies: Codable {
    var movies: [Movie] = []
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
// MARK: - Genre
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
