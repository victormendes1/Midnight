//
//  MovieDetailsInteractor.swift
//  Midnight
//
//  Created by Victor Mendes on 21/11/22.
//

import Combine

typealias MovieDetailsInteractorInput = MovieDetailsViewControllerOutput

// MARK: - Protocol
protocol MovieDetialInteractorOutput: AnyObject {
    func showDetails(response: MovieDetailsModels.Response)
    func showError(with error: ErrorRepresentation)
    func showLoading(active: Bool)
    func updateMovieStatus(_ updadeScene: Bool)
}

final class MovieDetailsInteractor {
    private var cancelable: AnyCancellable?
    private var worker: MovieDetailsWorker
    
    var presenter: MovieDetailsScenePresenterInput?
    
    init(worker: MovieDetailsWorker) {
        self.worker = worker
    }
}

// MARK: - Extension
extension MovieDetailsInteractor: MovieDetailsViewControllerIntput {
    func loadMovieDetails(request: MovieDetailsModels.Request) {
        self.presenter?.showLoading(active: true)
        cancelable = worker.performLoadMovieDetails(request)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.presenter?.showError(with: error.message)
            } receiveValue: { response in
                self.presenter?.showLoading(active: false)
                self.presenter?.showDetails(response: response)
            }
    }
    
    func updateMovieStatus(_ movie: Movie) {
       let updadeScene =  worker.performLoadFavoritesMoviesSaved().contains(where: { $0.id == movie.id })
        self.presenter?.updateMovieStatus(updadeScene)
    }
    
    func addFavoriteMovieList(_ movie: Movie) {
        worker.performSaveFavoriteMovie(movie)
    }
    
    func removeFavoriteMovieList(_ movie: Movie) {
        worker.performRemoveFavoriteMovie(movie)
    }
}
