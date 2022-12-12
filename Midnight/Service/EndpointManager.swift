//
//  EndpointManager.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation

enum EndpointManager {
   case singleMovie(String)
   case popularMovies
   case similarMovies(String)
   case moviePoster(String)
   case genres
    
   private var baseURL: String {
        switch self {
        case .singleMovie, .popularMovies, .similarMovies, .genres:
            return NetworkConstants.baseURL
        case .moviePoster:
            return NetworkConstants.backdropBaseURL
        }
    }
    
    private var endpoint: String {
        switch self {
        case .singleMovie(let id):
            return "/movie/\(id)"
            
        case .popularMovies:
            return "/movie/popular"
            
        case .similarMovies(let id):
            return "/movie/\(id)/similar"
            
        case .moviePoster(let backdropPath):
            return backdropPath
            
        case .genres:
            return "/genre/movie/list"
        }
    }
    
    private var parameters: [String: String] {
        var params: [String: String] = [:]
        
        switch self {
        case .singleMovie, .popularMovies, .similarMovies, .genres:
            params = NetworkConstants.defaultRequestParams
       
        case .moviePoster:
            params = [:]
        }
        
        switch self {
        case .singleMovie, .popularMovies, .similarMovies, .moviePoster, .genres:
            return params
        }
    }
    
    var url: URL? {
        let urlComponets = NSURLComponents(string: baseURL + endpoint)
        urlComponets?.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        return urlComponets?.url
    }
}
