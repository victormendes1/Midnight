//
//  MovieDetailsConfigurator.swift
//  Midnight
//
//  Created by Victor Mendes on 21/11/22.
//

import UIKit

// MARK: - Protocol
protocol MovieDetailsConfiguratorProtocol {
    func configured(_ viewController: MovieDetailsViewController, with movie: Movie) -> UIViewController
}

// MARK: - Extension SceneConfigurator
extension SceneConfigurator: MovieDetailsConfiguratorProtocol {
    func configured(_ viewController: MovieDetailsViewController, with movie: Movie) -> UIViewController {
        sceneFactory.configurator = self
        let interactor = MovieDetailsInteractor(worker: MovieDetailsWorker())
        let presenter = MovieDetailsPresenter()
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        viewController.selectedMovie = movie
        return viewController
    }
}
