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
    var imageBackground = PublishSubject<UIImageView>()
    
    public let loading = PublishSubject<Bool>()
    public let error = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    
    func requestMovies() {
        // Movie
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
        
        // Similar Movies
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
        
        // Genres
        provider.rx.request(.getGenres)
            .tryToMap(Genres.self)
            .subscribe(onSuccess: { genres in
                self.genres.onNext(genres)
            }, onFailure: { error in
                debugPrint(error)
            })
            .disposed(by: disposeBag)
        
        // Main Background
        movie
            .subscribe(onNext:{ movie in
                self.provider.rx.request(.getMovieBackground(movie.posterPath))
                    .subscribe(onSuccess: { response in
                        let imageView: UIImageView = UIImageView(image: UIImage(data: response.data))
                        self.imageBackground.onNext(imageView)
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
