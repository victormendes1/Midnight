//
//  FavoriteMoviesPresenter.swift
//  Midnight
//
//  Created by Victor Mendes on 28/01/23.
//

typealias FavoriteMoviesScenePresenterInput = FavoriteMoviesInteractorOutput
typealias FavoriteMoviesScenePresenterOutput = FavoriteMoviesViewControllerOutput

final class FavoriteMoviesPresenter {
    weak var viewController: FavoriteMoviesScenePresenterOutput?
}

// MARK: - Extension
extension FavoriteMoviesPresenter: FavoriteMoviesScenePresenterInput {
    func showFavoritesMovies(response: PopularMoviesModels.Response) {
        if let favoriteMoviesId = LikeListAccessObject.loadData() {
            let favoriteMovies = response.movies.filter { movie in
                favoriteMoviesId.contains(movie.id)
            }
            viewController?.showMovies(viewModel: .init(movies: favoriteMovies))
        }
    }
    
    func showError(wih error: ErrorRepresentation) {
        viewController?.showError(title: error.title, message: error.message)
    }
    
    func updateSceneBackground(has content: Bool) {
        viewController?.showSceneEmpty(has: content)
    }
}
