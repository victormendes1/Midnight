//
//  PopularMoviesWork.swift
//  Movie2You
//
//  Created by Victor Mendes on 21/11/22.
//

import Foundation
import RxSwift
import RxRelay
import Moya
import Resolver

protocol PopularMoviesWorkProtocol {
    func requestMovies() -> Observable<PopularMoviesModels.Response>
}

class PopularMoviesWork: PopularMoviesWorkProtocol {
    private let provider: MoyaProvider<MovieService> = Resolver.resolve()

    func requestMovies() -> Observable<PopularMoviesModels.Response> {
        provider.rx.request(.popularMovies)
            .observe(on: MainScheduler.instance)
            .mapTo(PopularMoviesModels.Response.self)
            .map { movies -> PopularMoviesModels.Response in
                debugPrint(movies)
                return PopularMoviesModels.Response.init(moveis: movies.moveis)
            }
            .asObservable()
    }
}
