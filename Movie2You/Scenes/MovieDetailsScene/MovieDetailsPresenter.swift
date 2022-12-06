//
//  MovieDetailsPresenter.swift
//  Movie2You
//
//  Created by Victor Mendes on 21/11/22.
//

import UIKit

typealias MovieDetailsScenePresenterInput = MovieDetialInteractorOutput
typealias MovieDetailsScenePresenterOutput = MovieDetailsViewControllerOutput

final class MovieDetailsPresenter {
    weak var viewController: MovieDetailsScenePresenterOutput?
}

extension MovieDetailsPresenter: MovieDetailsScenePresenterInput {
    func showMainMovie(movie: Movie) {
        viewController?.showMainMovie(movie: movie)
    }
    
    func showPoster(poster: UIImageView) {
        viewController?.showPoster(poster: poster)
    }
    
    func showSimilarMovies(movies: [Movie]) {
        viewController?.showSimilarMovies(movies: movies)
    }
}
