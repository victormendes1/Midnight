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
    public let genres = PublishSubject<Genres>()
    
    public let allMovies = PublishSubject<[Movies]>()
    public let loading = PublishSubject<Bool>()
    public let error = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    
    
    func requestMovies() {
        self.loading.onNext(true)
        provider.rx.request(.getMovie)
            .tryToMap(Movie.self)
            .subscribe(onSuccess: { movie in
                self.movie.onNext(movie)
            }, onFailure: { error in
                self.error.onNext(error) //TODO: - Esse erro vai ser apresentado na tela como popup
                self.loading.onNext(false)
                print(error)
            })
            .disposed(by: disposeBag)
        
        provider.rx.request(.getSimilarMovies)
            .tryToMap(SimilarMovies.self)
            .subscribe(onSuccess: { movies in
                self.similarMovies.onNext(movies)
            }, onFailure: { error in
                self.error.onNext(error) //TODO: - Esse erro vai ser apresentado na tela como popup
                self.loading.onNext(false)
                print(error)
            })
            .disposed(by: disposeBag)
        
        provider.rx.request(.getGenres)
            .tryToMap(Genres.self)
            .subscribe(onSuccess: { genres in
                self.genres.onNext(genres)
            }, onFailure: { error in
                debugPrint(error)
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(movie, similarMovies, genres)
            .subscribe(onNext: { value in
                self.allMovies.onNext( mapToMovies(data: value))
            })
            .disposed(by: disposeBag)
    }
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
