//
//  UpcomingDetailsConfigurator.swift
//  Midnight
//
//  Created by Victor Mendes on 15/12/22.
//

import UIKit

// MARK: - Protocol
protocol UpcomingDetailsConfiguratorProtocol {
    func configured(_ viewController: UpcomingDetailsViewController, with movie: Movie) -> UIViewController
}

// MARK: - Extension SceneConfigurator
extension SceneConfigurator: UpcomingDetailsConfiguratorProtocol {
    func configured(_ viewController: UpcomingDetailsViewController, with movie: Movie) -> UIViewController {
        sceneFactory.configurator = self
        let interactor = UpcomingDetailsInteractor(worker: UpcomingDetailsWorker())
        let presenter = UpcomingDetailsPresenter()
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.selectedMovie = movie
        viewController.interactor = interactor
        return viewController
    }
}
