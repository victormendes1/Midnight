//
//  Movie.swift
//  Midnight
//
//  Created by Victor Mendes on 07/01/22.
//

import UIKit

struct Movie: Codable {
    private let posterPath: String?
    let release: String
    let backdropPath: String?
    var genres: [Genre]?
    let genreId: [Int]?
    let id: Int
    let title: String
    let overview: String
    var duration: Int?
    let popularity: Double
    let voteCount: Int
    var posterImageData: UIImage?
    var trailerID: String?
    var liked: Bool?
    
    init(backdropPath: String = "",
         genres: [Genre] = [],
         genreId: [Int] = [],
         id: Int = .zero,
         title: String = "",
         overview: String = "",
         release: String = "",
         posterPath: String = "",
         duration: Int = .zero,
         popularity: Double = .zero,
         voteCount: Int = .zero,
         posterImageData: UIImage = UIImage(),
         trailerID: String = "",
         liked: Bool = false) {
        self.backdropPath = backdropPath
        self.genres = genres
        self.genreId = genreId
        self.id = id
        self.title = title
        self.overview = overview
        self.release = release
        self.posterPath = posterPath
        self.duration = duration
        self.popularity = popularity
        self.voteCount = voteCount
    }
}

// MARK: - Properties
extension Movie {
    var posterURL: URL? {
        URL(string: NetworkConstants.posterBaseURL + posterPathUnwrapped)
    }
    
    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: NetworkConstants.backdropBaseURL + backdropPath)
    }
    
    var posterPathUnwrapped: String {
        guard let posterPath = posterPath else { return "" }
        return posterPath
    }
    
    var releaseYearOnly: String {
        self.release.split(separator: "-").map({ String($0) }).first ?? ""
    }
    
    var longReleaseDate: Date {
        release.toDate() ?? Date()
    }
    
    var releaseDate: Date {
        releaseYearOnly.toDate() ?? Date()
    }
}

// MARK: - Extension CodingKeys
extension Movie {
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id
        case genreId = "genre_ids"
        case title
        case overview
        case popularity
        case posterPath = "poster_path"
        case duration = "runtime"
        case release = "release_date"
        case voteCount = "vote_count"
    }
}
