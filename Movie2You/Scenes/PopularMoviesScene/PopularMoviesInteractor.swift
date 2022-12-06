//
//  PopularMoviesInteractor.swift
//  Movie2You
//
//  Created by Victor Mendes on 21/11/22.
//

import RxSwift
import Combine

typealias PopularMoviesSceneInteractorInput = PopularMoviesViewControllerOutput

protocol PopularMoviesInteractorOutput: AnyObject {
    func showPopularMovies(response: PopularMoviesModels.Response)
}

final class PopularMoviesInteractor {
    private let disposeBag = DisposeBag()
    private var worker: PopularMoviesWorkProtocol
    
    var presenter: PopularMoviesScenePresenterInput?
    
    init(worker: PopularMoviesWorkProtocol) {
        self.worker = worker
    }
}

// MARK: - Extension
extension PopularMoviesInteractor: PopularMoviesViewControllerInput {
    func getMovies() {
        worker.requestMovies()
            .subscribe(onNext: { [weak self] content in
                guard let self = self else { return }
                let response = PopularMoviesModels.Response(moveis: content.moveis)
                self.presenter?.showPopularMovies(response: response)
            }).disposed(by: disposeBag)
    }
}
