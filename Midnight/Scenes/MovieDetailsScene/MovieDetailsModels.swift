//
//  MovieDetailsModels.swift
//  Midnight
//
//  Created by Victor Mendes on 05/12/22.
//

import UIKit

enum MovieDetailsModels {
    struct Request: Codable {
        var movie: Movie
    }
    
    struct Response: Codable, MovieCollection {
        var movies: [Movie]
        var posterData: Data?
        
        enum CodingKeys: String, CodingKey {
            case movies = "results"
            case posterData
        }
    }
    
    struct ViewModel {
        var similarMovies: [Movie]
        var posterImage: UIImageView
    }
}
