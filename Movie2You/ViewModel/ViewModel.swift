//
//  ViewModel.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation
import UIKit
import RxSwift
import Moya
import Resolver

class ViewModel {
    fileprivate let provider: MoyaProvider<MovieService> = Resolver.resolve()
    
    public let movie = PublishSubject<Movie>()
    public let similarMovies = PublishSubject<SimilarMovies>()
    public let genres = PublishSubject<Genres>()
    
    public let allMovies = PublishSubject<[Movies]>()
    public let errorDispatches = PublishSubject<ResultError>()
    var imageBackground = PublishSubject<UIImageView>()
    
    private let disposeBag = DisposeBag()
    
    // Download all necessary content
    func requestMovies() {
        // Main Movie
        provider.rx.request(.getMovie)
            .mapTo(Movie.self)
            .subscribe(onSuccess: { movie in
                self.movie.onNext(movie)
            }, onFailure: { error in
                self.errorDispatches.onNext(error.asResultError)
            })
            .disposed(by: disposeBag)
        
        // Similar Movies
        provider.rx.request(.getSimilarMovies)
            .mapTo(SimilarMovies.self)
            .subscribe(onSuccess: { movies in
                self.similarMovies.onNext(movies)
            }, onFailure: { error in
                self.errorDispatches.onNext(error.asResultError)
            })
            .disposed(by: disposeBag)
        
        // Genres
        provider.rx.request(.getGenres)
            .mapTo(Genres.self)
            .subscribe(onSuccess: { genres in
                self.genres.onNext(genres)
            }, onFailure: { error in
                self.errorDispatches.onNext(error.asResultError)
            })
            .disposed(by: disposeBag)
        
        // Main Background
        movie
            .subscribe(onNext:{ movie in
                self.provider.rx.request(.getMovieBackground(movie.posterPath))
                    .subscribe(onSuccess: { response in
                        let imageView: UIImageView = UIImageView(image: UIImage(data: response.data))
                        self.imageBackground.onNext(imageView)
                    }, onFailure: { error in
                        self.errorDispatches.onNext(error.asResultError)
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        // Transforming data into a single type
        Observable.combineLatest(movie, similarMovies, genres)
            .subscribe(onNext: { value in
                self.allMovies.onNext( mapToMovies(data: value))
            })
            .disposed(by: disposeBag)
    }
}
