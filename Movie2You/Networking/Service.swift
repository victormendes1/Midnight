//
//  Service.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation
import Moya

public enum MovieService {
    case requestMovie(String)
    case requestSimilarMovies(String)
}

extension MovieService: TargetType {
    public var baseURL: URL {
      URL(string: "https://api.themoviedb.org/3/")!
    }
    
    public var path: String {
        switch self {
        case .requestMovie:
            return ""
        case .requestSimilarMovies:
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .requestMovie, .requestSimilarMovies:
            return .get
        }
    }
    
    public var task: Task {
        var params: [String: Any] = [:]
        
        switch self {
        case let .requestMovie(movie), let .requestSimilarMovies(movie):
            params = ["movie_id": movie]
        }
        
        switch self {
        case .requestMovie(_), .requestSimilarMovies(_):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        let token = "e3097c7c82fd9906e4643a522ac3cdb1"
        let header = ["Content-Type":"application/json",
         "Authorization": token]
        return header
    }
}
