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
    func performRemoveFavoriteMovie(_ movie: Movie)
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
        guard let favoritesMovies = MoviesAccessObject.loadData() else {
            let error: ServiceError = .unknownError(description: "Unable to recover saved movies")
            let response: AnyPublisher<PopularMoviesModels.Response, ServiceError> = Fail(error: error)
                .eraseToAnyPublisher()
            return response
        }
        let response = PopularMoviesModels.Response(movies: favoritesMovies)
        return CurrentValueSubject(response)
            .eraseToAnyPublisher()
    }
    
    func performRemoveFavoriteMovie(_ movie: Movie) {
        MoviesAccessObject.removeItem(movie)
    }
    
    func favoriteMoviesCount() -> Int {
        MoviesAccessObject.favoriteMovies?.count ?? .zero
    }
}
