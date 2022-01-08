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
    
    public let movies: PublishSubject<Movie> = PublishSubject()
    public let similarMovies: PublishSubject<SimilarMovies> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error: PublishSubject<Error> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    func requestMovies() {
        self.loading.onNext(true)
        provider.rx.request(.getMovies)
            .tryToMap(Movie.self)
            .subscribe(
                onSuccess: { response in
                    self.movies.onNext(response)
                    debugPrint(response)
                    self.loading.onNext(false)
                }, onFailure: { error in
                    self.error.onNext(error) //TODO: - Esse erro vai ser apresentado na tela como popup
                    print(error)
                })
            .disposed(by: disposeBag)
    }
    
    func requestSimilarMovies() {
        self.loading.onNext(true)
        provider.rx.request(.getSimilarMovies)
            .tryToMap(SimilarMovies.self)
            .subscribe(
                onSuccess: { response in
                    self.similarMovies.onNext(response)
                    debugPrint(response)
                    self.loading.onNext(false)
                }, onFailure: { error in
                    self.error.onNext(error) //TODO: - Esse erro vai ser apresentado na tela como popup
                })
            .disposed(by: disposeBag)
    }
}
