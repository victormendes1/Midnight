//
//  MovieDetailsInteractor.swift
//  Movie2You
//
//  Created by Victor Mendes on 21/11/22.
//

import RxSwift

typealias MovieDetailsInteractorInput = MovieDetailsViewControllerOutput

protocol MovieDetialInteractorOutput: AnyObject {
    func showMainMovie(movie: Movie)
    func showPoster(poster: UIImageView)
    func showSimilarMovies(movies: [Movie])
}

final class MovieDetailsInteractor {
    private let disposeBag = DisposeBag()
    private var worker: MovieDetailsWorkerProtocol
    
    var presenter: MovieDetailsScenePresenterInput?
    
    init(worker: MovieDetailsWorkerProtocol) {
        self.worker = worker
    }
}

// MARK: - Extension
extension MovieDetailsInteractor: MovieDetailsViewControllerIntput {
    func getMovieDetails(request: MovieDetailsModels.Request) {
        worker.requestMovies(movieId: request.movieID)
        
        worker.movies
            .skip(while: { $0.isEmpty })
            .subscribe(onNext: { [weak self] movies in
                guard let self = self else { return }
                let mainMovie = self.worker.selectedMovie.value
                self.presenter?.showMainMovie(movie: mainMovie)
                self.presenter?.showSimilarMovies(movies: movies)
            }).disposed(by: disposeBag)
        
        worker.imageBackground
            .skip(1)
            .subscribe(onNext: { [weak self] image in
                guard let self = self else { return }
                self.presenter?.showPoster(poster: image)
            }).disposed(by: disposeBag)
    }
}
