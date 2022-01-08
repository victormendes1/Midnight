//
//  Registering.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation
import Resolver
import Moya

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { MoyaProvider<MovieService>() }
        register { ViewModel() }
    }
}
