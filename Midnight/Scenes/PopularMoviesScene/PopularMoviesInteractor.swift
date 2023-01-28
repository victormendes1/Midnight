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
}

final class PopularMoviesInteractor {
    private var cancelables: Set<AnyCancellable> = []
    private var worker: PopularMoviesWork
    
    var presenter: PopularMoviesScenePresenterInput?
    
    init(worker: PopularMoviesWork) {
        self.worker = worker
    }
}

// MARK: - Extension
extension PopularMoviesInteractor: PopularMoviesViewControllerInput {
    func loadMovies() {
        worker.performLoadPopularMovies()
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.presenter?.showError(wih: error.message)
            } receiveValue: { response in
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
}
