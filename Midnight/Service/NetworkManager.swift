//
//  NetworkManager.swift
//  Midnight
//
//  Created by Victor Mendes on 06/12/22.
//

import Foundation
import Combine

protocol Requestable {
    func request<T: Codable>(_ endpoint: EndpointManager) -> AnyPublisher<T, ServiceError>
    func requestRaw(_ endpoint: EndpointManager) -> AnyPublisher<Data, ServiceError>
}

final class NetworkManager {
    private let urlSession: URLSession
    
    init (urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

// MARK: - Extension
extension NetworkManager: Requestable {
    func request<T: Codable>(_ endpoint: EndpointManager) -> AnyPublisher<T, ServiceError> {
        guard let url = endpoint.url else {
            return Fail(error: ServiceError.invalidURL).eraseToAnyPublisher()
        }
        
        return urlSession.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse {
                    guard (200..<300).contains(httpResponse.statusCode) else {
                        throw ServiceError.invalidResponseCode(httpResponse.statusCode)
                    }
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> ServiceError in
                if let decodingError = error as? DecodingError {
                    let errorMessage = (decodingError as NSError).debugDescription
                    return ServiceError.decodingError(errorMessage)
                }
                return ServiceError.unknownError(description: error.localizedDescription)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - RequestRaw
    func requestRaw(_ endpoint: EndpointManager) -> AnyPublisher<Data, ServiceError> {
        guard let url = endpoint.url else {
            return Fail(error: ServiceError.invalidURL).eraseToAnyPublisher()
        }
        
        return urlSession.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse {
                    guard (200..<300).contains(httpResponse.statusCode) else {
                        throw ServiceError.invalidResponseCode(httpResponse.statusCode)
                    }
                }
                return data
            }
            .mapError { error in
                return ServiceError.unknownError(description: error.localizedDescription)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
