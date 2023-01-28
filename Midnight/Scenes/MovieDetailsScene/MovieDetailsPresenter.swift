//
//  MovieDetailsPresenter.swift
//  Midnight
//
//  Created by Victor Mendes on 21/11/22.
//

import UIKit

typealias MovieDetailsScenePresenterInput = MovieDetialInteractorOutput
typealias MovieDetailsScenePresenterOutput = MovieDetailsViewControllerOutput

final class MovieDetailsPresenter {
    weak var viewController: MovieDetailsScenePresenterOutput?
}

// MARK: - Extension
extension MovieDetailsPresenter: MovieDetailsScenePresenterInput {
    func showError(with error: ErrorRepresentation) {
        viewController?.showError(title: error.title, message: error.message)
    }
    
    func showDetails(response: MovieDetailsModels.Response) {
        guard let posterImage = UIImage(data: response.posterData ?? Data()) else { return }
        let viewModel = MovieDetailsModels.ViewModel(similarMovies: response.movies, posterImage: UIImageView(image: posterImage))
        viewController?.showDetails(viewModel: viewModel)
    }
}
