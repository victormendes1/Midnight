//
//  Service + Extension.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation
import RxSwift
import Moya

extension Single where Element == Response {
    func mapTo<D: Decodable>(_ type: D.Type) -> Single<D> {
        return self.asObservable().map { response in
            if (200...299).contains(response.statusCode) {
                let decoder = JSONDecoder()
                do {
                    return try response.map(type, using: decoder)
                } catch {
                    debugPrint(error)
                }
            }
            if response.statusCode == 401 {
                throw ResultError.authorizationError()
            }
            if (402...499).contains(response.statusCode) {
                throw ResultError.invalidRequest()
            }
            
            if (500...599).contains(response.statusCode) {
                throw ResultError.serverError()
            }
            throw ResultError.unknownError()
        }.asSingle()
    }
}
