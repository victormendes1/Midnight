//
//  MovieDetailsInteractor.swift
//  Midnight
//
//  Created by Victor Mendes on 21/11/22.
//

import Combine

typealias MovieDetailsInteractorInput = MovieDetailsViewControllerOutput

// MARK: - Protocol
protocol MovieDetialInteractorOutput: AnyObject {
    func showDetails(response: MovieDetailsModels.Response)
    func showError(with error: ErrorRepresentation)
}

final class MovieDetailsInteractor {
    private var cancelable: AnyCancellable?
    private var worker: MovieDetailsWorker
    
    var presenter: MovieDetailsScenePresenterInput?
    
    init(worker: MovieDetailsWorker) {
        self.worker = worker
    }
}

// MARK: - Extension
extension MovieDetailsInteractor: MovieDetailsViewControllerIntput {
    func getMovieDetails(request: MovieDetailsModels.Request) { }
    
    func loadMovieDetails(request: MovieDetailsModels.Request) {
        cancelable = worker.performLoadMovieDetails(request)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.presenter?.showError(with: error.message)
            } receiveValue: { response in
                self.presenter?.showDetails(response: response)
            }
    }
}
