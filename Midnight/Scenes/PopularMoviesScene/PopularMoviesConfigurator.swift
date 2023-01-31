//
//  PopularMoviesConfigurator.swift
//  Midnight
//
//  Created by Victor Mendes on 02/12/22.
//

import UIKit

// MARK: - Protocol
protocol PopularMovieSceneConfiguratorProtocol {
    func configured(_ viewController: PopularMoviesViewController) -> UIViewController
}

// MARK: - Extension SceneConfigurator
extension SceneConfigurator: PopularMovieSceneConfiguratorProtocol {
    func configured(_ viewController: PopularMoviesViewController) -> UIViewController {
        sceneFactory.configurator = self
        let interactor = PopularMoviesInteractor(worker: PopularMoviesWork())
        let presenter = PopularMoviesPresenter()
        let router = PopularMoviesSceneRouter(sceneFactory: sceneFactory)
        router.source = viewController
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        viewController.router = router
        return UINavigationController(rootViewController: viewController)
    }
}
