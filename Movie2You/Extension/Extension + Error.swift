//
//  Extension + Error.swift
//  Movie2You
//
//  Created by Victor Mendes on 11/01/22.
//

import Foundation

// To get error message need to convert to a different 'ResultError'
extension Error {
    var asResultError: ResultError {
        guard let error = self as? ResultError else { fatalError() }
        return error
    }
}
