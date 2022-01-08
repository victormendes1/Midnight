//
//  Service.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation
import Moya

public enum MovieService {
    case getMovies
    case getSimilarMovies
    case getMovieBackground(String)
    case getSimilarMoviesBackgrounds(String)
}

extension MovieService: TargetType {
    public var baseURL: URL {
        switch self {
        case .getMovies, .getSimilarMovies:
            guard let url = URL(string: "https://api.themoviedb.org/3/") else { fatalError() }
            return url
        case .getMovieBackground, .getSimilarMoviesBackgrounds:
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500/") else { fatalError() }
            return url
        }
    }
    
    public var path: String {
        switch self {
        case .getMovies:
            return "movie/500"
        case .getSimilarMovies:
            return "movie/500/similar"
        case let .getMovieBackground(backdropPath), let .getSimilarMoviesBackgrounds(backdropPath):
            return backdropPath
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getMovies, .getSimilarMovies, .getMovieBackground(_), .getSimilarMoviesBackgrounds(_):
            return .get
        }
    }
    
    public var task: Task {
        var params: [String: Any] = [:]
        
        switch self {
        case .getMovies, .getSimilarMovies:
            params = ["api_key": "e3097c7c82fd9906e4643a522ac3cdb1"]
        case .getMovieBackground(_), .getSimilarMoviesBackgrounds(_):
            params = [:]
        }
        
        switch self {
        case .getMovies, .getSimilarMovies, .getMovieBackground(_), .getSimilarMoviesBackgrounds(_):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        let header = ["Content-type": "application/json"]
        return header
    }
}
