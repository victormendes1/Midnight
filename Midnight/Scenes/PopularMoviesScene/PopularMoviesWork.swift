//
//  PopularMoviesWork.swift
//  Midnight
//
//  Created by Victor Mendes on 21/11/22.
//

import Combine

// MARK: - Protocol
protocol PopularMoviesWorkProtocol {
    func performLoadPopularMovies(_ page: Int) -> AnyPublisher<PopularMoviesModels.Response, ServiceError>
    func performLoadGenres() -> AnyPublisher<Genres, ServiceError>
}

final class PopularMoviesWork {
    private let service: NetworkManager
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
}

// MARK: - Extension
extension PopularMoviesWork: PopularMoviesWorkProtocol {
    func performLoadPopularMovies(_ page: Int = 1) -> AnyPublisher<PopularMoviesModels.Response, ServiceError> {
        service.request(.popularMovies(numberPage: page))
        
    }
    
    func performLoadGenres() -> AnyPublisher<Genres, ServiceError> {
        service.request(.genres)
    }
}
