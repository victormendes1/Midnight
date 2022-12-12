//
//  PopularMoviesWork.swift
//  Movie2You
//
//  Created by Victor Mendes on 21/11/22.
//

import Combine

protocol PopularMoviesWorkProtocol {
    func performLoadPopularMovies() -> AnyPublisher<PopularMoviesModels.Response, ServiceError>
}

final class PopularMoviesWork {
    private let service: NetworkManager
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
}

extension PopularMoviesWork: PopularMoviesWorkProtocol {
    func performLoadPopularMovies() -> AnyPublisher<PopularMoviesModels.Response, ServiceError> {
        service.request(.popularMovies)
    }
}
