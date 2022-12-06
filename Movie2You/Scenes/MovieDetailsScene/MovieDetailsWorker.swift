//
//  MovieDetailsWorker.swift
//  Movie2You
//
//  Created by Victor Mendes on 21/11/22.
//

import UIKit
import RxSwift
import RxRelay
import Moya
import Resolver

protocol MovieDetailsWorkerProtocol {
    var isLoading: BehaviorRelay<Bool> { get set }
    var movies: BehaviorRelay<[Movie]> { get set }
    var selectedMovie: BehaviorRelay<Movie> { get set }
    var imageBackground: PublishSubject<UIImageView> { get set }
    func requestMovies(movieId: String) 
}

class MovieDetailsWorker: MovieDetailsWorkerProtocol, Transformable {
    private let provider: MoyaProvider<MovieService> = Resolver.resolve()
    private let disposeBag = DisposeBag()
   
    var isLoading = BehaviorRelay<Bool>(value: false)
    var selectedMovie = BehaviorRelay<Movie>(value: Movie())
    var movies = BehaviorRelay<[Movie]>(value: [])
    var imageBackground = PublishSubject<UIImageView>()
    let errorDispatches = PublishSubject<ResultError>()
    
    func requestMovies(movieId: String) {
        provider.rx.request(.getMovie(movieId))
            .observe(on: MainScheduler.instance)
            .mapTo(Movie.self)
            .subscribe(onSuccess: { [weak self] movie in
                guard let self = self else { return }
                
                self.selectedMovie.accept(movie)
            }, onFailure: { error in
                self.errorDispatches.onNext(error.asResultError)
            }).disposed(by: disposeBag)
        
        provider.rx.request(.getSimilarMovies(movieId))
            .observe(on: MainScheduler.instance)
            .mapTo(MovieDetailsModels.Response.self)
            .subscribe(onSuccess: { [weak self] content in
                guard let self = self else { return }
                self.movies.accept(content.moveis)
                self.isLoading.accept(true)
            }, onFailure: { error in
                self.errorDispatches.onNext(error.asResultError)
            }).disposed(by: disposeBag)
        
        provider.rx.request(.getGenres)
            .observe(on: MainScheduler.instance)
            .mapTo(Genres.self)
            .subscribe(onSuccess: { [weak self] content in
                guard let self = self, !self.movies.value.isEmpty else { return }
                
                self.movies.accept(self.addGenres(genres: content.genres))
            }, onFailure: { error in
                self.errorDispatches.onNext(error.asResultError)
            }).disposed(by: disposeBag)
        
        selectedMovie
            .observe(on: MainScheduler.instance)
            .flatMap { [weak self] movie -> Single<Response> in
                guard let self = self else { return .just(Response(statusCode: .zero, data: .empty, request: nil, response: .none)) }
                return self.provider.rx.request(.getMovieBackground(movie.posterPath))
            }
            .subscribe(onNext: { [weak self] imageData in
                guard let self = self else { return }
                
                self.imageBackground.onNext(UIImageView(image: UIImage(data: imageData.data)))
            }, onError: { error in
                self.errorDispatches.onNext(error.asResultError)
            }).disposed(by: disposeBag)
    }
}
