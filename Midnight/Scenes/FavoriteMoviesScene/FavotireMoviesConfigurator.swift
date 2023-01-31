//
//  FavotireMoviesConfigurator.swift
//  Midnight
//
//  Created by Victor Mendes on 28/01/23.
//

import UIKit

// MARK: - Protocol
protocol FavotireMoviesSceneConfiguratorProtocol {
    func configured(_ viewController: FavotireMoviesViewController) -> UIViewController
}

// MARK: - Extension SceneConfigurator
extension SceneConfigurator: FavotireMoviesSceneConfiguratorProtocol {
    func configured(_ viewController: FavotireMoviesViewController) -> UIViewController {
        sceneFactory.configurator = self
        let interactor = FavoriteMoviesInteractor(worker: FavoriteMoviesWork())
        let presenter = FavoriteMoviesPresenter()
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        return UINavigationController(rootViewController: viewController)
    }
}
