//
//  FavoriteMoviesWork.swift
//  Midnight
//
//  Created by Victor Mendes on 28/01/23.
//

import Combine

// MARK: - Protocol
protocol FavoriteMoviesWorkProtocol {
    func performLoadFavoriteMovies() -> AnyPublisher<PopularMoviesModels.Response, ServiceError>
}

final class FavoriteMoviesWork {
    private let service: NetworkManager
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
}

// MARK: - Extension
extension FavoriteMoviesWork: FavoriteMoviesWorkProtocol {
    func performLoadFavoriteMovies() -> AnyPublisher<PopularMoviesModels.Response, ServiceError> {
        service.request(.popularMovies())
    }
}
