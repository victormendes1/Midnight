//
//  UpcomingMoviesConfigurator.swift
//  Midnight
//
//  Created by Victor Mendes on 13/12/22.
//

import UIKit

// MARK: - Protocol
protocol UpcomingMoviesSceneConfiguratorProtocol {
    func configured(_ viewController: UpcomingMoviesViewController) -> UIViewController
}

// MARK: - Extension SceneConfigurator
extension SceneConfigurator: UpcomingMoviesSceneConfiguratorProtocol {
    func configured(_ viewController: UpcomingMoviesViewController) -> UIViewController {
        sceneFactory.configurator = self
        let interactor = UpcomingMoviesInteractor(worker: UpcomingMoviesWorker())
        let presenter = UpcomingMoviesPresenter()
        let router = UpcomingMoviesSceneRouter(sceneFactory: sceneFactory)
        router.source = viewController
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        viewController.router = router
        return UINavigationController(rootViewController: viewController)
    }
}
