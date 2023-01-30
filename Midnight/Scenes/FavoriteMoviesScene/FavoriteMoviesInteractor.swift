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
        guard let favoriteMoviesId = LikeListAccessObject.loadData(), favoriteMoviesId.count != movieCount else { return }
        loadFavoriteMovies()
    }
    
    func updateSceneBackground(_ moviesCount: Int) {
        if let content = LikeListAccessObject.loadData()?.count {
            self.presenter?.updateSceneBackground(has: content != .zero)
        }
    }
    
    func removeSelectedMovieFromFavorites(id: Int, count: Int) {
        LikeListAccessObject.removeItem(id)
        if count == 1 {
            self.presenter?.updateSceneBackground(has: false)
        }
    }
}
