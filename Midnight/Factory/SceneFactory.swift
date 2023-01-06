//
//  SceneFactory.swift
//  Midnight
//
//  Created by Victor Mendes on 01/12/22.
//

import UIKit

// MARK: - Protocol
protocol SceneFactoryProtocol {
    var configurator: SceneConfigurator! { get set }
    func makeHomeScene() -> UIViewController
    func makePopularMoviesScene() -> UIViewController
    func makeUpcomingMoviesScene() -> UIViewController
    func makeMovieDetailsScene(with movie: Movie) -> UIViewController
}

// MARK: - Class
final class SceneFactory {
    var configurator: SceneConfigurator!
}

// MARK: - Extension
extension SceneFactory: SceneFactoryProtocol {
    func makeHomeScene() -> UIViewController {
        let viewController = HomeTabController()
        return configurator.configured(viewController, viewControllers: [makePopularMoviesScene(), makeUpcomingMoviesScene()])
    }
    
    func makePopularMoviesScene() -> UIViewController {
        let viewController = PopularMoviesViewController()
        return configurator.configured(viewController)
    }
    
    func makeMovieDetailsScene(with movie: Movie) -> UIViewController {
        let viewController = MovieDetailsViewController()
        return configurator.configured(viewController, with: movie)
    }
    
    func makeUpcomingMoviesScene() -> UIViewController {
        let viewController = UpcomingMoviesViewController()
        return configurator.configured(viewController)
    }
    
    func makUpcomingDetailsScene(with movie: Movie) -> UIViewController {
        let viewController = UpcomingDetailsViewController()
        return configurator.configured(viewController, with: movie)
    }
}

