//
//  MovieDetailsWorker.swift
//  Midnight
//
//  Created by Victor Mendes on 21/11/22.
//

import Foundation
import Combine

// MARK: - Protocol
protocol MovieDetailsWorkerProtocol {
    func performLoadMovieDetails(_ movie: MovieDetailsModels.Request) -> AnyPublisher<MovieDetailsModels.Response, ServiceError>
    func performSaveFavoriteMovie(_ movie: Movie)
    func performRemoveFavoriteMovie(_ movie: Movie)
    func fetchSimilarMovies(_ movieID: String) -> AnyPublisher<MovieDetailsModels.Response, ServiceError>
    func fetchPoster(_ posterPath: String) -> AnyPublisher<Data, ServiceError>
}

final class MovieDetailsWorker {
    private let service: NetworkManager
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
}

// MARK: - Extension
extension MovieDetailsWorker: MovieDetailsWorkerProtocol {
    func performLoadMovieDetails(_ request: MovieDetailsModels.Request) -> AnyPublisher<MovieDetailsModels.Response, ServiceError> {
        Publishers.Zip(fetchSimilarMovies(request.movie.id.description),
                       fetchPoster(request.movie.posterPathUnwrapped))
            .map { similar, poster in
                return MovieDetailsModels.Response.init(movies: similar.movies, posterData: poster)
            }
            .eraseToAnyPublisher()
    }
    
    internal func fetchSimilarMovies(_ movieID: String) -> AnyPublisher<MovieDetailsModels.Response, ServiceError> {
        service.request(.similarMovies(movieID))
    }
    
    internal func fetchPoster(_ posterPath: String) -> AnyPublisher<Data, ServiceError> {
        service.requestRaw(.moviePoster(posterPath))
    }
    
    func performSaveFavoriteMovie(_ movie: Movie) {
        movie.liked = true
        MoviesAccessObject.saveData(movie)
    }
    
    func performRemoveFavoriteMovie(_ movie: Movie) {
        movie.liked = false
        MoviesAccessObject.removeItem(movie)
    }
    
    func performLoadFavoritesMoviesSaved() -> [Movie] {
        MoviesAccessObject.favoriteMovies ?? []
    }
}
