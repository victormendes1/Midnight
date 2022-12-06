//
//  SceneFactory.swift
//  Movie2You
//
//  Created by Victor Mendes on 01/12/22.
//

import UIKit

protocol SceneFactoryProtocol {
    var configurator: SceneConfigurator! { get set }
    func makePopularMoviesScene() -> UIViewController
    func makeMovieDetailsScene(with movieID: String) -> UIViewController
}

final class SceneFactory {
    var configurator: SceneConfigurator!
    
    func makePopularMoviesScene() -> UIViewController {
        let viewController = PopularMoviesViewController()
        return configurator.configured(viewController)
    }
    
    func makeMovieDetailsScene(with movieID: String) -> UIViewController {
        let viewController = MovieDetailsViewController()
        return configurator.configured(viewController, with: movieID)
    }
}
