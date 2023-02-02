//
//  FavoriteMoviesInteractor.swift
//  Midnight
//
//  Created by Victor Mendes on 28/01/23.
//

import Combine

typealias FavoriteMoviesInteractorInput = FavoriteMoviesViewControllerOutput

// MARK: Protocol
protocol FavoriteMoviesInteractorOutput: AnyObject {
    func showFavoritesMovies(response: PopularMoviesModels.Response)
    func showError(wih error: ErrorRepresentation)
    func updateSceneBackground(has content: Bool)
    func updadeStateSearchBar(hide: Bool)
}

final class FavoriteMoviesInteractor {
    private var cancelable: AnyCancellable?
    private var worker: FavoriteMoviesWork
    
    var presenter: FavoriteMoviesScenePresenterInput?
    
    init(worker: FavoriteMoviesWork) {
        self.worker = worker
    }
}

// MARK: - Extension
extension FavoriteMoviesInteractor: FavoriteMoviesViewControllerInput {
    func loadFavoriteMovies() {
        cancelable = worker.performLoadFavoriteMovies()
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.presenter?.showError(wih: error.message)
            } receiveValue: { response in
                self.presenter?.showFavoritesMovies(response: .init(movies: response.movies))
            }
    }
    
    func updateFavoriteMoviesList(_ movieCount: Int) {
        let savedMovieCount = worker.favoriteMoviesCount()
        if savedMovieCount != movieCount {
            loadFavoriteMovies()
        }
    }
    
    func updateSceneBackground() {
        let savedMovieCount = worker.favoriteMoviesCount()
        presenter?.updateSceneBackground(has: savedMovieCount != .zero)
        presenter?.updadeStateSearchBar(hide: savedMovieCount == .zero)
    }
    
    func removeSelectedMovieFromFavorites(_ movie: Movie) {
        let savedMovieCount = worker.favoriteMoviesCount()
        presenter?.updateSceneBackground(has: savedMovieCount != 1)
        worker.performRemoveFavoriteMovie(movie)
    }
}
