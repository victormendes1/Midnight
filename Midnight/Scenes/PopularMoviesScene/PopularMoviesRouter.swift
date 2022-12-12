//
//  PopularMoviesRouter.swift
//  Movie2You
//
//  Created by Victor Mendes on 04/12/22.
//

import UIKit

protocol PopularMoviesSceneRoutingLogic {
    func showMovieDetails(movie: Movie)
}

final class PopularMoviesSceneRouter {
    private var sceneFactory: SceneFactory
    
    weak var source: UIViewController?
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}

// MARK: - Extension
extension PopularMoviesSceneRouter: PopularMoviesSceneRoutingLogic {
    func showMovieDetails(movie: Movie) {
        let scene = sceneFactory.makeMovieDetailsScene(with: movie)
        source?.navigationController?.pushViewController(scene, animated: true)
    }
}
