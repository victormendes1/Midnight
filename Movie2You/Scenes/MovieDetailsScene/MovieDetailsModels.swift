//
//  MovieDetailsModels.swift
//  Movie2You
//
//  Created by Victor Mendes on 05/12/22.
//

import UIKit

enum MovieDetailsModels {
    struct Request: Codable {
        var movieID: String
    }
    
    struct Response: Codable, MovieCollection {
        var moveis: [Movie]
        
        enum CodingKeys: String, CodingKey {
            case moveis = "results"
        }
    }
    
    struct ViewModel {
        var mainMovie: Movie
        var similarMovie: [Movie]
        var poster: UIImageView
    }
}
