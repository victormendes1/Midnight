//
//  PopularMoviesInteractorTests.swift
//  MidnightTests
//
//  Created by Victor Mendes on 01/02/23.
//

import XCTest
import Combine
@testable import Midnight

final class PopularMoviesInteractorTests: XCTestCase {
    private var sut: PopularMoviesInteractor!
    private var worker: PopularMoviesWorkMock!
    private var presenter: PopularPresenterInputMock!
    
    override func setUpWithError() throws {
        worker = PopularMoviesWorkMock()
        sut = PopularMoviesInteractor(worker: worker)
        presenter = PopularPresenterInputMock()
        sut.presenter = presenter
    }
    
    override func tearDownWithError() throws {
        sut = nil
        worker = nil
        presenter = nil
    }
    
    func test_givingInteraction_whenLoadingMovies_thenThePresenterMustShowMovies() throws {
        // given
        let expectation = expectation(description: "Wait for loadMovies to return with movies")
        let response = PopularMoviesModels.Response.init(movies: Stub.movies)
        worker.responseMoviesStub = CurrentValueSubject(response)
            .eraseToAnyPublisher()
        //when
        sut.loadMovies()
        expectation.fulfill()
        // then
        waitForExpectations(timeout: 0.2)
        XCTAssertTrue(presenter.showPopularMoviesCalled)
        XCTAssertEqual(presenter.showMoviesData.movies.first?.title, "Puss in Boots: The Last Wish")
    }
    
    func test_givingInteraction_whenLoadingMovies_thenThePresenterMustShowError() throws {
        // given
        let expectation = expectation(description: "Wait for loadMovies to return with error")
        let response: ServiceError = .serverError
        worker.responseMoviesStub = Fail(error: response)
            .eraseToAnyPublisher()
        //when
        sut.loadMovies()
        expectation.fulfill()
        // then
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(presenter.showErrorCalled)
        XCTAssertEqual(presenter.showMessageError.title, "Erro no servidor")
    }
    
    func test_givenEmptyGenres_whenLoadingGenres_thenMustWorkerLoadGenresWithSuccess() throws {
        // given
        GenresAccessObject.saveData([])
        let response: Genres = .init(genres: [
            Genre(id: 11, name: "action")!
        ])
        worker.responseGenresStub = CurrentValueSubject(response)
            .eraseToAnyPublisher()
        //when
        sut.loadGenres()
        // then
        XCTAssertTrue(worker.performLoadGenresCalled)
        XCTAssertEqual(GenresAccessObject.loadData()?.first?.name, "action")
    }
    
    func test_givenEmptyGenres_whenLoadingGenres_workerShouldShowError() throws {
        //given
        GenresAccessObject.saveData([])
        let response: ServiceError = .serverError
        worker.responseGenresStub = Fail(error: response)
            .eraseToAnyPublisher()
        //when
        sut.loadGenres()
        // then
        XCTAssertEqual(presenter.showMessageError.title, "Erro no servidor")
    }
}
