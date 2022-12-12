//
//  PopularMoviesModels.swift
//  Movie2You
//
//  Created by Victor Mendes on 22/11/22.
//

import Foundation

enum PopularMoviesModels {
    struct Request: Codable { }
    
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
