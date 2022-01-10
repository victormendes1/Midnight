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
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestMovies()
        initialSetting()
        configureBindings()
    }
    // MARK: - Bindings
    func configureBindings() {
        // Background
        viewModel
            .imageBackground
            .subscribe(onNext: configureHeaderView(_:))
            .disposed(by: disposeBag)
        
        // TableView
        viewModel
            .allMovies
            .bind(to: tableView.rx.items) { tableview, row, movies in
                let index = IndexPath(row: row, section: 0)
                switch row {
                case 0:
                    let cell: MainMovieTableViewCell = tableview.dequeueReusableCell(index)
                    guard let movie = movies.mainMovie else { fatalError() }
                    cell.selectionStyle = .none
                    cell.configure(movie)
                    return cell
                default:
                    let cell: SimilarMoviesTableViewCell = tableview.dequeueReusableCell(index)
                    cell.selectionStyle = .none
                    cell.configure(movies)
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
    // MARK: - Private Functions
    private func initialSetting() {
        tableView.register(type: SimilarMoviesTableViewCell.self)
        tableView.register(type: MainMovieTableViewCell.self)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
    }
    
    private func configureHeaderView(_ imageView: UIImageView) {
        let headerView = StretchyHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 450))
        headerView.imageView.image = imageView.image
        self.tableView.tableHeaderView = headerView
    }
}
// MARK: - Extension
extension MainViewController: UIScrollViewDelegate, UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerView = self.tableView.tableHeaderView as? StretchyHeaderView else { return }
        headerView.scrollViewDidScroll(scrollView: tableView)
    }
}
