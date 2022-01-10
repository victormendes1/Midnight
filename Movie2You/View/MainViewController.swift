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
    
    var movies = PublishSubject<[Movies]>()
    var imageBackgroundView = UIImageView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestMovies()
        configureCell()
        configureBindings()
    }
    // MARK: - Bindings
    func configureBindings() {
        // Background
        viewModel
            .imageBackground
            .subscribe(onNext: { imageView in
                self.imageBackgroundView = imageView
                self.imageBackgroundView.clipsToBounds = true
                self.imageBackgroundView.contentMode = .top
                self.tableView.tableHeaderView = self.imageBackgroundView
                self.tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400)
                self.tableView.tableHeaderView?.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
        
        // TableView
        viewModel
            .allMovies
            .bind(to: tableView.rx.items) { tableview, row, movies in
                switch row {
                case 0:
                    let cell: MainMovieTableViewCell = tableview.dequeueReusableCell(IndexPath(row: row, section: 0))
                    guard let movie = movies.mainMovie else { fatalError() }
                    cell.selectionStyle = .none
                    cell.configure(movie)
                    return cell
                default:
                    let cell: SimilarMoviesTableViewCell = tableview.dequeueReusableCell(IndexPath(row: row, section: 0))
                    cell.selectionStyle = .none
                    cell.configure(movies)
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
    // MARK: - Private Functions
    private func configureCell() {
        tableView.register(type: SimilarMoviesTableViewCell.self)
        tableView.register(type: MainMovieTableViewCell.self)
        tableView.contentInsetAdjustmentBehavior = .never
    }
}
