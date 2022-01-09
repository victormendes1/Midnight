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
import Kingfisher

class MainViewController: UIViewController {
    fileprivate var viewModel: ViewModel = Resolver.resolve()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageBackgroundView: UIImageView!
    
    var similarMovies: PublishSubject<[Movie]> = PublishSubject()
    var genres: BehaviorSubject<[Genre]> = BehaviorSubject(value: [])
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(type: SimilarMoviesTableViewCell.self)
        viewModel.requestGenres()
        viewModel.requestMovies()
        viewModel.requestSimilarMovies()
        view.addSubview(imageBackgroundView)
        configureBindings()
    }
    
    // MARK: - Bindings
    func configureBindings() {
        // SimilarMovies
        viewModel
            .similarMovies
            .map{ $0.movies }
            .bind(to: similarMovies)
            .disposed(by: disposeBag)
        
        // Genre
        viewModel
            .listGenre
            .map{ $0.genres }
            .bind(to: genres)
            .disposed(by: disposeBag)
        
        // Background
        //        viewModel
        //            .movie
        //            .subscribe(onNext: { movie in
        //                self.imageBackgroundView.kf.setImage(with: movie.backdropURL())
        //            })
        //            .disposed(by: disposeBag)
        
        // TableView
        similarMovies
            .bind(to: tableView.rx.items) { tableView, row, movie  in
                let cell: SimilarMoviesTableViewCell = tableView.dequeueReusableCell(IndexPath(row: row, section: 0))
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

