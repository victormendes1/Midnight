//
//  PopularMoviesInteractor.swift
//  Midnight
//
//  Created by Victor Mendes on 21/11/22.
//

import Combine

typealias PopularMoviesSceneInteractorInput = PopularMoviesViewControllerOutput

// MARK: - Protocol
protocol PopularMoviesInteractorOutput: AnyObject {
    func showPopularMovies(response: PopularMoviesModels.Response)
    func showError(wih error: ErrorRepresentation)
    func changeStateOfSelectedMovie(_ ids: [Int])
    func presentLoadingScene(active: Bool)
}

final class PopularMoviesInteractor {
    private var cancelables: Set<AnyCancellable> = []
    private var worker: PopularMoviesWork
    private var requestedPages: Int = .zero
    private var savedFavoritesMovies: [Int] {
        MoviesAccessObject.favoriteMovies?.map { $0.id } ?? []
    }
    
    var presenter: PopularMoviesScenePresenterInput?
    
    init(worker: PopularMoviesWork) {
        self.worker = worker
    }
}

// MARK: - Extension
extension PopularMoviesInteractor: PopularMoviesViewControllerInput {
    func loadMovies() {
        self.presenter?.presentLoadingScene(active: true)
        
        requestedPages += 1
        worker.performLoadPopularMovies(requestedPages)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.presenter?.showError(wih: error.message)
            } receiveValue: { response in
                response.movies.forEach { movie in
                    if self.savedFavoritesMovies.contains(movie.id) {
                        movie.liked = true
                    }
                }
                self.presenter?.presentLoadingScene(active: false)
                self.presenter?.showPopularMovies(response: response)
            }
            .store(in: &cancelables)
    }
    
    func loadGenres() {
        if GenresAccessObject.loadData() == nil {
            worker.performLoadGenres()
                .sink { completion in
                    guard case let .failure(error) = completion else { return }
                    self.presenter?.showError(wih: error.message)
                } receiveValue: { response in
                    GenresAccessObject.saveData(response.genres)
                }
                .store(in: &cancelables)
        }
    }
    
    func updateListFavorite() {
        self.presenter?.changeStateOfSelectedMovie(savedFavoritesMovies)
    }
}

