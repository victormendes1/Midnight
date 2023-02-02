//
//  PopularPresenterInputMock.swift
//  MidnightTests
//
//  Created by Victor Mendes on 01/02/23.
//

import Foundation
import Combine
@testable import Midnight

// MARK: - Helpers
final class PopularMoviesWorkMock: PopularMoviesWorkProtocol {
    var responseMoviesStub: AnyPublisher<PopularMoviesModels.Response, ServiceError> = Empty(completeImmediately: false)
        .eraseToAnyPublisher()
    var performLoadMoviesCalled = false
    
    func performLoadPopularMovies(_ page: Int) -> AnyPublisher<PopularMoviesModels.Response, ServiceError> {
        performLoadMoviesCalled = true
        return responseMoviesStub
    }
    
    var performLoadGenresCalled = false
    var responseGenresStub: AnyPublisher<Genres, ServiceError> = Empty(completeImmediately: false)
        .eraseToAnyPublisher()
    
    func performLoadGenres() -> AnyPublisher<Genres, ServiceError> {
        performLoadGenresCalled = true
        return responseGenresStub
    }
}

final class PopularPresenterInputMock: PopularMoviesScenePresenterInput {
    var showPopularMoviesCalled = false
    var showMoviesData: PopularMoviesModels.Response!
   
    func showPopularMovies(response: PopularMoviesModels.Response) {
        showPopularMoviesCalled = true
        showMoviesData = response
    }
    var showErrorCalled = false
    var showMessageError: ErrorRepresentation!
   
    func showError(wih error: ErrorRepresentation) {
        showErrorCalled = true
        showMessageError = error
    }
    
    var changedStateSceneCalled = false
    var changingMovieState: [Int]!
    
    func changeStateOfSelectedMovie(_ ids: [Int]) {
        changedStateSceneCalled = true
        changingMovieState = ids
    }
    
    var presentedLoadingCalled = false
   
    func presentLoadingScene(active: Bool) {
        presentedLoadingCalled = true
    }
}
