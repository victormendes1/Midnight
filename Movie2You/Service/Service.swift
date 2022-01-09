//
//  Service.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation
import Moya

public enum MovieService {
    case getMovie
    case getSimilarMovies
    case getMovieBackground(String)
    case getSimilarMoviesBackgrounds(String)
    case getGenres
}

extension MovieService: TargetType {
    public var baseURL: URL {
        switch self {
        case .getMovie, .getSimilarMovies, .getGenres:
            guard let url = URL(string: NetworkConstants.baseURL) else { fatalError() }
            return url
        case .getMovieBackground, .getSimilarMoviesBackgrounds:
            guard let url = URL(string: NetworkConstants.backdropBaseURL) else { fatalError() }
            return url
        }
    }
    
    public var path: String {
        switch self {
        case .getMovie:
            return "movie/500"
        case .getSimilarMovies:
            return "movie/500/similar"
        case let .getMovieBackground(backdropPath), let .getSimilarMoviesBackgrounds(backdropPath):
            return backdropPath
        case .getGenres:
            return "genre/movie/list"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getMovie, .getSimilarMovies, .getMovieBackground(_), .getSimilarMoviesBackgrounds(_), .getGenres:
            return .get
        }
    }
    
    public var task: Task {
        var params: [String: Any] = [:]
        
        switch self {
        case .getMovie, .getSimilarMovies, .getGenres:
            params = NetworkConstants.defaultRequestParams
        case .getMovieBackground(_), .getSimilarMoviesBackgrounds(_):
            params = [:]
        }
        
        switch self {
        case .getMovie, .getSimilarMovies, .getMovieBackground(_), .getSimilarMoviesBackgrounds(_), .getGenres:
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        let header = NetworkConstants.defaultRequestHeaders
        return header
    }
}
