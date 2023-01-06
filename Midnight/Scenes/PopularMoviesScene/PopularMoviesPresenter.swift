//
//  PopularMoviesPresenter.swift
//  Midnight
//
//  Created by Victor Mendes on 21/11/22.
//


typealias PopularMoviesScenePresenterInput = PopularMoviesInteractorOutput
typealias PopularMoviesScenePresenterOutput = PopularMoviesViewControllerOutput

final class PopularMoviesPresenter {
    weak var viewController: PopularMoviesScenePresenterOutput?
}

// MARK: - Extension
extension PopularMoviesPresenter: PopularMoviesScenePresenterInput {
    func showError(wih error: ErrorRepresentation) {
        viewController?.showError(title: error.title, message: error.message)
    }
    
    func showPopularMovies(response: PopularMoviesModels.Response) {
        let viewModel = PopularMoviesModels.ViewModel(movies: response.movies)
        viewController?.showMovies(viewModel: viewModel)
    }
}
