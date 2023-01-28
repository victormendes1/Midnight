//
//  NetworkConstants.swift
//  Midnight
//
//  Created by Victor Mendes on 08/01/22.
//

import Foundation

struct NetworkConstants {
    static let defaultRequestKey = "api_key"
    static let defaultRequestValue = getEnvironmentVar("api_key")
    static let defaultRegionKey = "region"
    static let defaultRegionValue = "us"
    static let defaultRequestHeaders = ["Content-type": "application/json"]
    static let baseURL = "https://api.themoviedb.org/3"
    static let posterBaseURL = "https://image.tmdb.org/t/p/w300"
    static let backdropBaseURL = "https://www.themoviedb.org/t/p/original/"
}

extension NetworkConstants {
    static let defaultRequestParams = [
        defaultRequestKey: defaultRequestValue,
        defaultRegionKey: defaultRegionValue
    ]
}
