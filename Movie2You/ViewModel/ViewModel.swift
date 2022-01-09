//
//  ViewModel.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation
import RxSwift
import Moya
import Resolver

class ViewModel {
    fileprivate let provider: MoyaProvider<MovieService> = Resolver.resolve()
    
    public let movie = PublishSubject<Movie>()
    public let similarMovies = PublishSubject<SimilarMovies>()
    public let listGenre = PublishSubject<Genres>()
    public let loading = PublishSubject<Bool>()
    public let error = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    
    func requestMovie() {
        self.loading.onNext(true)
        provider.rx.request(.getMovies)
            .tryToMap(Movie.self)
            .subscribe(
                onSuccess: { response in
                    self.movie.onNext(response)
                }, onFailure: { error in
                    self.error.onNext(error) //TODO: - Esse erro vai ser apresentado na tela como popup
                    self.loading.onNext(false)
                    print(error)
                })
            .disposed(by: disposeBag)
    }
    
//    func requestMovieBackground(_ backdropPath: String) {
//        provider.rx.request(.getMovieBackground(backdropPath))
//        // - TODO: converter para imagem
//            .subscribe(
//                onSuccess: { response in
//                    self.loading.onNext(false)
//                }, onFailure: { error in
//                    self.error.onNext(error) //TODO: - Esse erro vai ser apresentado na tela como popup
//                    self.loading.onNext(false)
//                    print(error)
//                })
//            .disposed(by: disposeBag)
//    }
    
    func requestSimilarMovies() {
        self.loading.onNext(true)
        provider.rx.request(.getSimilarMovies)
            .tryToMap(SimilarMovies.self)
            .subscribe(
                onSuccess: { response in
                    self.similarMovies.onNext(response)
                }, onFailure: { error in
                    self.error.onNext(error) //TODO: - Esse erro vai ser apresentado na tela como popup
                    self.loading.onNext(false)
                    print(error)
                })
            .disposed(by: disposeBag)
    }
    
    func requestGenres() {
        provider.rx.request(.getGenres)
            .tryToMap(Genres.self)
            .subscribe(onSuccess: { response in
                self.listGenre.onNext(response)
            }, onFailure: { error in
                debugPrint(error)
            })
            .disposed(by: disposeBag)
    }
}
