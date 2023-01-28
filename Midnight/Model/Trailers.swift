//
//  Trailers.swift
//  Midnight
//
//  Created by Victor Mendes on 04/01/23.
//

import Foundation

struct Trailers: Codable {
    let id: Int
    let results: [Trailer]
}

struct Trailer: Codable {
    let key: String
}
