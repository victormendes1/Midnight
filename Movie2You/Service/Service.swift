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
}

extension MovieService: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/") else { fatalError() }
        return url
    }
    
    public var path: String {
        switch self {
        case .getMovies:
            return "movie/500"
        case .getSimilarMovies:
            return "movie/500/similar"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getMovies, .getSimilarMovies:
            return .get
        }
    }
    
    public var task: Task {
        var params: [String: Any] = [:]
        
        switch self {
        case .getMovies, .getSimilarMovies:
            params = ["api_key": "e3097c7c82fd9906e4643a522ac3cdb1"]
        }
        
        switch self {
        case .getMovies, .getSimilarMovies:
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        let header = ["Content-type": "application/json"]
        return header
    }
}
