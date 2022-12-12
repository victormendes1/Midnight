//
//  MovieDetailsConfigurator.swift
//  Movie2You
//
//  Created by Victor Mendes on 21/11/22.
//

import UIKit

protocol MovieDetailsConfiguratorProtocol {
    func configured(_ viewController: MovieDetailsViewController, with movie: Movie) -> UIViewController
}

extension SceneConfigurator: MovieDetailsConfiguratorProtocol {
    @discardableResult
    func configured(_ viewController: MovieDetailsViewController, with movie: Movie) -> UIViewController {
        sceneFactory.configurator = self
        let interactor = MovieDetailsInteractor(worker: MovieDetailsWorker())
        let presenter = MovieDetailsPresenter()
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        viewController.selectedMovie = movie
        // TODO: Adicionar roteador.
        //let router = MovieDetailsRou (sceneFactory: sceneFactory)
        // router.source = viewController
        //viewController.router
        //viewController.router = router
        return viewController
    }
}
