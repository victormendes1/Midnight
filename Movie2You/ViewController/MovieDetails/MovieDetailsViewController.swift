//
//  MovieDetailsViewController.swift
//  Movie2You
//
//  Created by Victor Mendes on 31/10/22.
//

import UIKit
import Moya
import Resolver
import RxSwift
import RxCocoa
import SnapKit

final class MovieDetailsViewController: UIViewController, Alert {
    private let disposeBag = DisposeBag()
    private var viewModel: ViewModel = Resolver.resolve()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height / 2.1))
        tableView.register(MainMovieCell.self, forCellReuseIdentifier: MainMovieCell.identifier)
        tableView.register(SimilarMoviesCell.self, forCellReuseIdentifier: SimilarMoviesCell.identifier)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationController()
    }
    
    // MARK: - Private Functions
    private func setupBindings() {
        viewModel.requestMovies()
        
        viewModel.imageBackground
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: configureHeaderView(_:))
            .disposed(by: disposeBag)
        
        viewModel.errorDispatches
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                guard let self = self else { return }
                
                self.showAlert(error.title, error.message, self)
            }).disposed(by: disposeBag)
        
        viewModel.similarMovies
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { tableView in
            tableView.width.height.equalToSuperview()
        }
    }
    
    private func configureHeaderView(_ imageView: UIImageView) {
        let headerView = StretchyHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height / 2.1))
        headerView.alpha = 0
        headerView.imageView.image = imageView.image
        addShadowTop(place: self.view)
        addShadowBottom(headerView)
        self.tableView.tableHeaderView = headerView
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            headerView.alpha = 1
        })
    }
}
// MARK: - Extension UITableView
extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mainCell = tableView.dequeueReusableCell(withIdentifier: MainMovieCell.identifier, for: indexPath) as? MainMovieCell, let similarCell = tableView.dequeueReusableCell(withIdentifier: SimilarMoviesCell.identifier, for: indexPath) as? SimilarMoviesCell else { return UITableViewCell() }
        
        switch indexPath.row {
        case .zero:
            mainCell.configure(viewModel.movie.value)
            return mainCell
            
        default:
            similarCell.configure(viewModel.movies.value[indexPath.row])
            return similarCell
        }
    }
}

// MARK: - Extension ScrollView
extension MovieDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerView = self.tableView.tableHeaderView as? StretchyHeaderView else { return }
        headerView.scrollViewDidScroll(scrollView: tableView)
    }
}
