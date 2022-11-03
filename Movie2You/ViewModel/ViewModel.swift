//
//  ViewModel.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import UIKit
import RxSwift
import Moya
import Resolver
import RxRelay

class ViewModel {
    private let provider: MoyaProvider<MovieService> = Resolver.resolve()
    private let disposeBag = DisposeBag()
    
    let movie = BehaviorRelay<Movie>(value: Movie())
    public let similarMovies = BehaviorRelay<SimilarMovies>(value: SimilarMovies())
    public let genres = BehaviorRelay<Genres>(value: Genres())
    
    public let movies = BehaviorRelay(value: [Movies]())
    public let errorDispatches = PublishSubject<ResultError>()
    var imageBackground = PublishSubject<UIImageView>()
    
    
    // Download all necessary content
    func requestMovies() {
        // Requesting Main Movie
        provider.rx.request(.getMovie)
            .mapTo(Movie.self)
            .subscribe(onSuccess: { [weak self] movie in
                guard let self = self else { return }
                
                self.movie.accept(movie)
            }, onFailure: { error in
                self.errorDispatches.onNext(error.asResultError)
            }).disposed(by: disposeBag)
        
        // Requesting Similar Movies
        provider.rx.request(.getSimilarMovies)
            .mapTo(SimilarMovies.self)
            .subscribe(onSuccess: { [weak self] movies in
                guard let self = self else { return }
                
                self.similarMovies.accept(movies)
            }, onFailure: { error in
                self.errorDispatches.onNext(error.asResultError)
            })
            .disposed(by: disposeBag)
        
        // Requesting Genres
        provider.rx.request(.getGenres)
            .mapTo(Genres.self)
            .subscribe(onSuccess: { [weak self] genres in
                guard let self = self else { return }
                self.genres.accept(genres)
            }, onFailure: { error in
                self.errorDispatches.onNext(error.asResultError)
            })
            .disposed(by: disposeBag)
        
        // Requesting Main Background
        movie
            .subscribe(onNext: { movie in
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
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                
                self.movies.accept(mapToMovies(data: value))
            })
            .disposed(by: disposeBag)
    }
}
