//
//  ViewModel.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    
    public enum Error {
        case internetError(String)
        case serverMessage(String)
    }
    
    public let movies: PublishSubject<[Movie]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error: PublishSubject<Error> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    func requestMovies() {
        self.loading.onNext(true)
        
    }
    
}
