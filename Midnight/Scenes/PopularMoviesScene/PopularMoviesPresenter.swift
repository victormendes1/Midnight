//
//  PopularMoviesPresenter.swift
//  Midnight
//
//  Created by Victor Mendes on 21/11/22.
//


typealias PopularMoviesScenePresenterInput = PopularMoviesInteractorOutput
typealias PopularMoviesScenePresenterOutput = PopularMoviesViewControllerOutput

final class PopularMoviesPresenter {
    weak var viewController: PopularMoviesScenePresenterOutput?
}

// MARK: - Extension
extension PopularMoviesPresenter: PopularMoviesScenePresenterInput {
    func showError(wih error: ErrorRepresentation) {
        viewController?.showError(title: error.title, message: error.message)
    }
    
    func showPopularMovies(response: PopularMoviesModels.Response, ids: [Int]?) {
        if let favoriteMovieIds = ids {
            response.movies.forEach { movie in
                if favoriteMovieIds.contains(movie.id) {
                    movie.liked = true
                } 
            }
        }
        let viewModel = PopularMoviesModels.ViewModel(movies: response.movies)
        viewController?.showMovies(viewModel: viewModel)
    }
    
    func changeStateOfSelectedMovie(_ liked: Bool, _ movieID: Int?) {
        viewController?.changeStateOfSelectedMovie(liked, movieID)
    }
    
    func presentLoadingScene(active: Bool) {
        viewController?.showLoading(active: active)
    }
}
