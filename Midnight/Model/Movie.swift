//
//  Movie.swift
//  Midnight
//
//  Created by Victor Mendes on 07/01/22.
//

import UIKit

final class Movie: NSObject, NSCoding, Codable {
    private let posterPath: String?
    let release: String /// "2022-12-21"
    let backdropPath: String?
    let genreId: [Int]?
    let id: Int
    let title: String
    let overview: String
    var duration: Int?
    let popularity: Double
    let voteCount: Int
    var posterImageData: UIImage?
    var trailerID: String?
    var liked: Bool = false
    
    init(backdropPath: String = "", genreId: [Int] = [], id: Int = .zero, title: String = "", overview: String = "", release: String = "", posterPath: String = "", duration: Int = .zero, popularity: Double = .zero, voteCount: Int = .zero, posterImageData: UIImage = UIImage(), trailerID: String = "", liked: Bool = false) {
        self.backdropPath = backdropPath
        self.genreId = genreId
        self.id = id
        self.title = title
        self.overview = overview
        self.release = release
        self.posterPath = posterPath
        self.duration = duration
        self.popularity = popularity
        self.voteCount = voteCount
        self.posterImageData = posterImageData
        self.liked = liked
    }
    
    required convenience init?(coder: NSCoder) {
        let posterPath = coder.decodeObject(forKey: PropertyKey.posterPath) as? String ?? ""
        let release = coder.decodeObject(forKey: PropertyKey.release) as? String ?? ""
        let backdropPath = coder.decodeObject(forKey: PropertyKey.backdropPath) as? String ?? ""
        let genreId = coder.decodeObject(forKey: PropertyKey.genreId) as? [Int] ?? []
        let id = coder.decodeInteger(forKey: PropertyKey.id)
        let title = coder.decodeObject(forKey: PropertyKey.title) as? String ?? ""
        let overview = coder.decodeObject(forKey: PropertyKey.overview) as? String ?? ""
        let popularity = coder.decodeDouble(forKey: PropertyKey.popularity)
        let voteCount = coder.decodeInteger(forKey: PropertyKey.voteCount)
        let liked = coder.decodeBool(forKey: PropertyKey.liked)
        
        self.init(backdropPath: backdropPath, genreId: genreId, id: id, title: title, overview: overview, release: release, posterPath: posterPath, popularity: popularity, voteCount: voteCount, liked: liked)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(posterPath, forKey: PropertyKey.posterPath)
        coder.encode(release, forKey: PropertyKey.release)
        coder.encode(backdropPath, forKey: PropertyKey.backdropPath)
        coder.encode(genreId, forKey: PropertyKey.genreId)
        coder.encode(id, forKey: PropertyKey.id)
        coder.encode(title, forKey: PropertyKey.title)
        coder.encode(overview, forKey: PropertyKey.overview)
        coder.encode(popularity, forKey: PropertyKey.popularity)
        coder.encode(voteCount, forKey: PropertyKey.voteCount)
        coder.encode(liked, forKey: PropertyKey.liked)
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
    
    /// e.g. "2023"
    var releaseYearOnly: String {
        self.release.split(separator: "-").map({ String($0) }).first ?? ""
    }
    /// e.g. 2022-12-21 03:00:00 UTC
    var longReleaseDate: Date {
        release.toDate() ?? Date()
    }
}

// MARK: - Extension CodingKeys
extension Movie {
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
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

extension Movie {
    struct PropertyKey {
        static let posterPath = "posterPath"
        static let release = "release"
        static let backdropPath = "backdropPath"
        static let genreId = "genreId"
        static let id = "id"
        static let title = "title"
        static let overview = "overview"
        static let duration = "duration"
        static let popularity = "popularity"
        static let voteCount = "voteCount"
        static let posterImageData = "posterImageData"
        static let trailerID = "trailerID"
        static let liked = "liked"
    }
}
