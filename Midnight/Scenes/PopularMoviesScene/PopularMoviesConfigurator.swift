//
//  PopularMoviesConfigurator.swift
//  Movie2You
//
//  Created by Victor Mendes on 02/12/22.
//

import UIKit

protocol PopularMovieSceneConfiguratorProtocol {
    func configured(_ viewController: PopularMoviesViewController) -> UIViewController
}

extension SceneConfigurator: PopularMovieSceneConfiguratorProtocol {
    @discardableResult
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
        return viewController
    }
}
