//
//  UpcomingMoviesPresenter.swift
//  Midnight
//
//  Created by Victor Mendes on 13/12/22.
//

typealias UpcomingMoviesScenePresenterInput = UpcomingMoviesInteractorOutput
typealias UpcomingMoviesScenePresenterOutput = UpcomingMoviesSceneOutput

final class UpcomingMoviesPresenter {
    weak var viewController: UpcomingMoviesScenePresenterOutput?
}

// MARK: - Extension
extension UpcomingMoviesPresenter: UpcomingMoviesScenePresenterInput {
    func showUpcomingMovies(response: UpcomingMoviesModels.Response) {
        let viewModel = UpcomingMoviesModels.ViewModel(movies: response.movies)
        viewController?.showMovies(viewModel: viewModel)
    }
    
    func showError(wih error: ErrorRepresentation) {
        viewController?.showError(title: error.title, message: error.message)
    }
}
