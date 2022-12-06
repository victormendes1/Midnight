//
//  PopularMoviesRouter.swift
//  Movie2You
//
//  Created by Victor Mendes on 04/12/22.
//

import UIKit

protocol PopularMoviesSceneRoutingLogic {
    func showMovieDetails(movieID: String)
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
    func showMovieDetails(movieID: String) {
        let scene = sceneFactory.makeMovieDetailsScene(with: movieID)
        source?.navigationController?.pushViewController(scene, animated: true)
    }
}
