//
//  UpcomingDetailsPresenter.swift
//  Midnight
//
//  Created by Victor Mendes on 15/12/22.
//

typealias UpcomingDetailsScenePresenterInput = UpcomingDetailsInteractorOutput
typealias UpcomingDetailsScenePresenterOutput = UpcomingDetailsSceneOutput

final class UpcomingDetailsPresenter {
    weak var viewController: UpcomingDetailsScenePresenterOutput?
}

// MARK: - Extension
extension UpcomingDetailsPresenter: UpcomingDetailsScenePresenterInput {
    func showDetails(response: UpcomingDetailsModels.Response) {
        guard let mainMovie = response.featuredMovie else { return }
        let viewModel = UpcomingDetailsModels.ViewModel(featuredMovie: mainMovie, similaresMovies: response.movies, trailer: response.trailer?.key ?? "")
        viewController?.showDetails(viewModel: viewModel)
    }
    
    func showError(wih error: ErrorRepresentation) {
        viewController?.showError(title: error.title, message: error.message)
    }
}
