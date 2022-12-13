//
//  PopularMoviesInteractor.swift
//  Movie2You
//
//  Created by Victor Mendes on 21/11/22.
//

import Combine

typealias PopularMoviesSceneInteractorInput = PopularMoviesViewControllerOutput

protocol PopularMoviesInteractorOutput: AnyObject {
    func showPopularMovies(response: PopularMoviesModels.Response)
    func showError(wih error: ErrorRepresentation)
}

final class PopularMoviesInteractor {
    private var cancelable: AnyCancellable?
    private var worker: PopularMoviesWork
    
    var presenter: PopularMoviesScenePresenterInput?
    
    init(worker: PopularMoviesWork) {
        self.worker = worker
    }
}

// MARK: - Extension
extension PopularMoviesInteractor: PopularMoviesViewControllerInput {
    func loadMovies() {
        cancelable = worker.performLoadPopularMovies()
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.presenter?.showError(wih: error.message)
            } receiveValue: { response in
                self.presenter?.showPopularMovies(response: response)
            }
    }
    
    func loadGenres() {
        if GenresAccessObject.loadData() == nil {
            cancelable = worker.performLoadGenres()
                .sink { completion in
                    guard case let .failure(error) = completion else { return }
                    self.presenter?.showError(wih: error.message)
                } receiveValue: { response in
                    GenresAccessObject.saveData(response.genres)
                }
        }
    }
}
