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
        guard let favoriteMoviesId = LikeListAccessObject.favoriteMovies, favoriteMoviesId.count != movieCount else { return }
        loadFavoriteMovies()
    }
    
    func updateSceneBackground() {
        let content = LikeListAccessObject.favoriteMovies?.count ?? .zero
        self.presenter?.updateSceneBackground(has: content != .zero)
    }
    
    func removeSelectedMovieFromFavorites(id: Int, count: Int) {
        LikeListAccessObject.removeItem(id)
        self.presenter?.updateSceneBackground(has: count != 1)
    }
}
