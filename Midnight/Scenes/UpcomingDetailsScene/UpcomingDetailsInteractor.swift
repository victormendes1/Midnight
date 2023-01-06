//
//  UpcomingDetailsInteractor.swift
//  Midnight
//
//  Created by Victor Mendes on 15/12/22.
//

import Combine

typealias UpcomingDetailsSceneInteractorInput = UpcomingDetailsSceneOutput

// MARK: - Protocol
protocol UpcomingDetailsInteractorOutput: AnyObject {
    func showDetails(response: UpcomingDetailsModels.Response)
    func showError(wih error: ErrorRepresentation)
}

final class UpcomingDetailsInteractor {
    private var cancelable: AnyCancellable?
    private var worker: UpcomingDetailsWorker
    
    var presenter: UpcomingDetailsScenePresenterInput?
    
    init(worker: UpcomingDetailsWorker) {
        self.worker = worker
    }
}

// MARK: - Extension
extension UpcomingDetailsInteractor: UpcomingDetailsSceneInput {
    func loadDetails(request: UpcomingDetailsModels.Request) {
        cancelable = worker.performLoadDetails(request)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                self.presenter?.showError(wih: error.message)
            } receiveValue: { response in
                self.presenter?.showDetails(response: response)
            }
    }
}
