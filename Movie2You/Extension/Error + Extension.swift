//
//  Error + Extension.swift
//  Movie2You
//
//  Created by Victor Mendes on 11/01/22.
//

import Foundation

public extension Error {
    var asResultError: ResultError {
        guard let error = self as? ResultError else { fatalError() }
        return error
    }
}
