//
//  MovieCollection.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/11/22.
//

import Foundation

protocol MovieCollection: Codable {
    var moveis: [Movie] { get }
}
