//
//  UpcomingDetailsModels.swift
//  Midnight
//
//  Created by Victor Mendes on 15/12/22.
//
import UIKit

enum UpcomingDetailsModels {
    struct Request: Codable {
        let movie: Movie
    }
    
    struct Response: Codable {
        var movies: [Movie]
        var featuredMovie: Movie?
        var posters: Data?
        var trailer: Trailer?
        
        enum CodingKeys: String, CodingKey {
            case movies = "results"
        }
    }
    
    struct ViewModel {
        let featuredMovie: Movie
        let similaresMovies: [Movie]
        let trailer: String
    }
}
