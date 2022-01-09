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
    
    var movies = PublishSubject<[Movies]>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestMovies()
        configureCell()
        configureBindings()
    }
    
    // MARK: - Bindings
    func configureBindings() {
        viewModel
            .allMovies
            .bind(to: tableView.rx.items) { tableview, row, movies in
                switch row {
                case 0:
                    let cell: MainMovieTableViewCell = tableview.dequeueReusableCell(IndexPath(row: row, section: 0))
                    guard let movie = movies.mainMovie else { fatalError() }
                        cell.configure(movie)
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
    }
        
    private func configureCell() {
        tableView.register(type: SimilarMoviesTableViewCell.self)
        tableView.register(type: MainMovieTableViewCell.self)
    }
}
