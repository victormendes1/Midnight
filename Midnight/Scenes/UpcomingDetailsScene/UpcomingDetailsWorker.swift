//
//  UpcomingDetailsWorker.swift
//  Midnight
//
//  Created by Victor Mendes on 15/12/22.
//

import Combine
import UIKit

// MARK: - Protocol
protocol UpcomingDetailsWorkerProtocol {
    func performLoadDetails(_ request: UpcomingDetailsModels.Request) -> AnyPublisher<UpcomingDetailsModels.Response, ServiceError>
    func fetchFeaturedMovie(_ movieID: String) -> AnyPublisher<Movie, ServiceError>
    func fetchPathTrailer(_ movieID: String)  -> AnyPublisher<Trailers, ServiceError>
    func fetchSimilarMovies(_ movieID: String) -> AnyPublisher<UpcomingDetailsModels.Response, ServiceError> 
}

final class UpcomingDetailsWorker {
    private let service: NetworkManager
    
    init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
}

// MARK: - Extension
extension UpcomingDetailsWorker: UpcomingDetailsWorkerProtocol {
    func performLoadDetails(_ request: UpcomingDetailsModels.Request) -> AnyPublisher<UpcomingDetailsModels.Response, ServiceError> {
        Publishers.Zip3(fetchSimilarMovies(request.movie.id.description),
                        fetchFeaturedMovie(request.movie.id.description),
                        fetchPathTrailer(request.movie.id.description))
            .map { response -> UpcomingDetailsModels.Response in
                return .init(movies: response.0.movies, featuredMovie: response.1, trailer: response.2.results.first)
            }
            .eraseToAnyPublisher()
    }
    
    internal func fetchFeaturedMovie(_ movieID: String) -> AnyPublisher<Movie, ServiceError> {
        service.request(.singleMovie(movieID))
    }
    
    internal func fetchPathTrailer(_ movieID: String)  -> AnyPublisher<Trailers, ServiceError> {
        service.request(.trailer(movieID))
    }
    
    internal func fetchSimilarMovies(_ movieID: String) -> AnyPublisher<UpcomingDetailsModels.Response, ServiceError> {
        service.request(.similarMovies(movieID))
    }
}
