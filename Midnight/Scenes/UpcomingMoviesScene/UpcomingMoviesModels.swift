//
//  UpcomingMoviesModels.swift
//  Midnight
//
//  Created by Victor Mendes on 13/12/22.
//

import Foundation

enum UpcomingMoviesModels {
    struct Request: Codable {
        let movie: Movie
    }
    
    struct Response: Codable, MovieCollection {
        var movies: [Movie]
        
        enum CodingKeys: String, CodingKey {
            case movies = "results"
        }
    }
    
    struct ViewModel {
        let movies: [Movie]
    }
}
