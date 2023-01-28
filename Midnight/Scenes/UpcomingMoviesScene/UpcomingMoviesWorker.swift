//
//  UpcomingMoviesWorker.swift
//  Midnight
//
//  Created by Victor Mendes on 13/12/22.
//

import Combine

// MARK: - Protocol
protocol UpcomingMoviesWorkerProtocol {
    func performUpcomingMovies() -> AnyPublisher<UpcomingMoviesModels.Response, ServiceError>
}

final class UpcomingMoviesWorker {
    private let service: NetworkManager
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
}

// MARK: - Extension
extension UpcomingMoviesWorker: UpcomingMoviesWorkerProtocol {
    func performUpcomingMovies() -> AnyPublisher<UpcomingMoviesModels.Response, ServiceError> {
        service.request(.upcomingMovies)
    }
}
