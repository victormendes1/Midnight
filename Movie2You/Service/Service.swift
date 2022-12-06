//
//  Service.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Moya

public enum MovieService {
    case getMovie(String)
    case getSimilarMovies(String)
    case getMovieBackground(String)
    case getSimilarMoviesBackgrounds(String)
    case getGenres
    case popularMovies
}
// MARK: - Extension
extension MovieService: TargetType {
    public var baseURL: URL {
        switch self {
        case .getMovie, .getSimilarMovies, .getGenres, .popularMovies:
            guard let url = URL(string: NetworkConstants.baseURL) else { fatalError() }
            return url
        case .getMovieBackground, .getSimilarMoviesBackgrounds:
            guard let url = URL(string: NetworkConstants.backdropBaseURL) else { fatalError() }
            return url
        }
    }
    
    public var path: String {
        switch self {
        case .getMovie(let id):
            return "movie/\(id)"
        
        case .getSimilarMovies(let id):
            return "movie/\(id)/similar"
        
        case let .getMovieBackground(backdropPath), let .getSimilarMoviesBackgrounds(backdropPath):
            return backdropPath
        
        case .getGenres:
            return "genre/movie/list"
            
        case .popularMovies:
            return "movie/popular"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getMovie, .getSimilarMovies, .getMovieBackground(_), .getSimilarMoviesBackgrounds(_), .getGenres, .popularMovies:
            return .get
        }
    }
    
    public var task: Task {
        var params: [String: Any] = [:]
        
        switch self {
        case .getMovie, .getSimilarMovies, .getGenres, .popularMovies:
            params = NetworkConstants.defaultRequestParams
       
        case .getMovieBackground(_), .getSimilarMoviesBackgrounds(_):
            params = [:]
        }
        
        switch self {
        case .getMovie, .getSimilarMovies, .getMovieBackground(_), .getSimilarMoviesBackgrounds(_), .getGenres, .popularMovies:
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        let header = NetworkConstants.defaultRequestHeaders
        return header
    }
}
