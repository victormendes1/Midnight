//
//  MovieDetailsWorker.swift
//  Movie2You
//
//  Created by Victor Mendes on 21/11/22.
//

import UIKit
import Combine

protocol MovieDetailsWorkerProtocol {
    func performLoadMovieDetails(_ movie: MovieDetailsModels.Request) -> AnyPublisher<MovieDetailsModels.Response, ServiceError>
    func fetchSimilarMovies(_ movieID: String) -> AnyPublisher<MovieDetailsModels.Response, ServiceError>
    func fetchPoster(_ posterPath: String) -> AnyPublisher<Data, ServiceError>
}

final class MovieDetailsWorker {
    private let service: NetworkManager
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
}

extension MovieDetailsWorker: MovieDetailsWorkerProtocol {
    func performLoadMovieDetails(_ request: MovieDetailsModels.Request) -> AnyPublisher<MovieDetailsModels.Response, ServiceError> {
        Publishers.Zip(fetchSimilarMovies(request.movie.id.description), fetchPoster(request.movie.posterPath))
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
}
