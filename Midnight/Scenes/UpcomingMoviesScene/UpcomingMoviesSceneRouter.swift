//
//  UpcomingMoviesSceneRouter.swift
//  Midnight
//
//  Created by Victor Mendes on 15/12/22.
//

import UIKit

// MARK: - Protocol
protocol UpcomingMoviesSceneRoutingLogic {
    func showMovieDetails(movie: Movie)
}

final class UpcomingMoviesSceneRouter {
    private var sceneFactory: SceneFactory
    
    weak var source: UIViewController?
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}

// MARK: - Extension
extension UpcomingMoviesSceneRouter: UpcomingMoviesSceneRoutingLogic {
    func showMovieDetails(movie: Movie) {
        let scene = sceneFactory.makUpcomingDetailsScene(with: movie)
        source?.navigationController?.present(scene, animated: true)
    }
}
