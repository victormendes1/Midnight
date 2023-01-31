//
//  UpcomingMoviesInteractor.swift
//  Midnight
//
//  Created by Victor Mendes on 13/12/22.
//

import Foundation
import Combine

typealias UpcomingMoviesSceneInteractorInput = UpcomingMoviesSceneOutput

protocol UpcomingMoviesInteractorOutput: AnyObject {
    func showUpcomingMovies(response: UpcomingMoviesModels.Response)
    func showError(wih error: ErrorRepresentation)
    func showLoading(active: Bool)
}

final class UpcomingMoviesInteractor {
    private var cancelable: AnyCancellable?
    private var worker: UpcomingMoviesWorker
    
    var presenter: UpcomingMoviesScenePresenterInput?
    
    init(worker: UpcomingMoviesWorker) {
        self.worker = worker
    }
}

// MARK: - Extension
extension UpcomingMoviesInteractor: UpcomingMoviesSceneInput {
    func loadMovies() {
        self.presenter?.showLoading(active: true)
        cancelable = worker.performUpcomingMovies()
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.presenter?.showError(wih: error.message)
            } receiveValue: { response in
                self.presenter?.showLoading(active: false)
                self.presenter?.showUpcomingMovies(response: response)
            }
    }
}
