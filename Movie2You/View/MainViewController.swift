//
//  MainViewController.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import UIKit
import Moya
import Resolver
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    fileprivate var viewModel: ViewModel = Resolver.resolve()
    @IBOutlet var tableView: UITableView!
    
    var similarMovies: PublishSubject<[Movie]> = PublishSubject()
    var genres: BehaviorSubject<[Genre]> = BehaviorSubject(value: [])
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(type: SimilarMoviesTableViewCell.self)
        viewModel.requestGenres()
        //viewModel.requestMovies()
        viewModel.requestSimilarMovies()
        
        configureBindings()
    }
    
    func configureBindings() {
        // MARK: - SimilarMovies
        viewModel
            .similarMovies
            .map{ $0.movies }
            .bind(to: similarMovies)
            .disposed(by: disposeBag)
        
        // MARK: - Genre
        viewModel
            .listGenre
            .map{ $0.genres }
            .bind(to: genres)
            .disposed(by: disposeBag)
        
        // MARK: - TableView
        similarMovies
            .bind(to: tableView.rx.items) { tableview, row, movie  in
                let cell: SimilarMoviesTableViewCell = tableview.dequeueReusableCell(IndexPath(row: row, section: 0))
                self.genres
                    .subscribe(onNext: { genres in
                        cell.configure(movie, list: genres)
                    })
                    .disposed(by: self.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let imageView = UIImageView(image: UIImage(systemName: "circle"))
        return imageView
    }
}

