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
    func updadeStateSearchBar(hide: Bool) {
        viewController?.setStateSearchBar(hide: hide)
    }
    
    func showFavoritesMovies(response: PopularMoviesModels.Response) {
        viewController?.showMovies(viewModel: .init(movies: response.movies))
    }
    
    func showError(wih error: ErrorRepresentation) {
        viewController?.showError(title: error.title, message: error.message)
    }
    
    func updateSceneBackground(has content: Bool) {
        viewController?.showSceneEmpty(has: content)
    }
}
