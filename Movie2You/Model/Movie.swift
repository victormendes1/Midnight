//
//  Movie.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation

struct Movie: Codable {
    private let release: String
    let backdropPath: String?
    var genres: [Genre]?
    let genreId: [Int]?
    let id: Int
    let originalTitle: String
    let posterPath: String
    let popularity: Double
    let voteCount: Int
    
    init(backdropPath: String = "", genres: [Genre] = [], genreId: [Int] = [], id: Int = .zero, originalTitle: String = "", release: String = "", posterPath: String = "", popularity: Double = .zero, voteCount: Int = .zero) {
        self.backdropPath = backdropPath
        self.genres = genres
        self.genreId = genreId
        self.id = id
        self.originalTitle = originalTitle
        self.release = release
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
        case release = "release_date"
        case voteCount = "vote_count"
    }
}

extension Movie {
    var posterURL: URL? {
        URL(string: NetworkConstants.posterBaseURL + posterPath)
    }
    
    var organizedGenres: String {
        genreId?.compactMap { number -> String in
            self.genres?.filter({ $0.id == number }).map({ $0.name}).joined() ?? ""
        }.filter({ $0 != "" }).prefix(2).sorted(by: <).joined(separator: ", ") ?? ""
    }
    
    var releaseDate: String {
        self.release.split(separator: "-").map({ String($0) }).first ?? ""
    }
}
