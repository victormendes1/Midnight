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
    
    var allMovieData = PublishSubject<[MoviesData]>()
    let disposeBag = DisposeBag()
    var similarMovies = PublishSubject<[Movie]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAllData()
        configureCell()
        configureBindings()
    }
    
    // MARK: - Bindings
    func configureBindings() {
        // Unificando os dados
        Observable.combineLatest(viewModel.movie,
                                 viewModel.similarMovies.map{ $0.movies },
                                 viewModel.listGenre.map { $0.genres })
            .subscribe(onNext: { data in
                self.allMovieData.onNext(mapToMovieData(data))
            })
            .disposed(by: disposeBag)
        
        viewModel
            .similarMovies
            .map{ $0.movies }
            .bind(to: similarMovies)
            .disposed(by: disposeBag)
        
        viewModel
            .similarMovies
            .map { $0.movies }
            .bind(to: tableView.rx.items) { tableview, row, movies in
                switch row {
                case 0:
                    let cell: MainMovieTableViewCell = tableview.dequeueReusableCell(IndexPath(row: row, section: 0))
                    cell.configure(movies)
                    return cell
                    
                default:
                    let cell: SimilarMoviesTableViewCell = tableview.dequeueReusableCell(IndexPath(row: row, section: 0))
                    cell.configure(movies)
                    return cell
                }
            }
            .disposed(by: disposeBag)
        
        // Background
        //        viewModel
        //            .movie
        //            .subscribe(onNext: { movie in
        //                self.imageBackgroundView.kf.setImage(with: movie.backdropURL())
        //            })
        //            .disposed(by: disposeBag)
        
        // TableView
//        allMovieData
//            .bind(to: tableView.rx.items) { tableview, row, moviesData in
//                switch row {
//                case 0:
//                    let cell: MainMovieTableViewCell = tableview.dequeueReusableCell(IndexPath(row: row, section: 0))
//                    cell.configure(moviesData.mainMovie)
//                    return cell
//
//                default:
//                    let cell: SimilarMoviesTableViewCell = tableview.dequeueReusableCell(IndexPath(row: row, section: 0))
//                    cell.titleLabel.text = "Cell - \(row)"
//                    //cell.configure(moviesData.similarMovies[row], listGeners: moviesData.gender)
//                    return cell
//                }
//            }
//            .disposed(by: disposeBag)
    }
    
    private func requestAllData() {
        viewModel.requestGenres()
        viewModel.requestMovie()
        viewModel.requestSimilarMovies()
    }
    
    private func configureCell() {
        tableView.register(type: SimilarMoviesTableViewCell.self)
        tableView.register(type: MainMovieTableViewCell.self)
    }
}
