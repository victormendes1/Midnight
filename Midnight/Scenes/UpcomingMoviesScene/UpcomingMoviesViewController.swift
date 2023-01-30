//
//  UpcomingMoviesViewController.swift
//  Midnight
//
//  Created by Victor Mendes on 13/12/22.
//

import UIKit
import SnapKit

// MARK: - Protocol
protocol UpcomingMoviesSceneInput: AnyObject {
    func loadMovies()
}

protocol UpcomingMoviesSceneOutput: AnyObject, Alert {
    func showMovies(viewModel: UpcomingMoviesModels.ViewModel)
    func showError(title: String, message: String)
}

// MARK: - Class
final class UpcomingMoviesViewController: UIViewController {
    var interactor: UpcomingMoviesSceneInput?
    var router: UpcomingMoviesSceneRouter?
    
    private var movies: [Movie] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.register(UpcomingMoviesCell.self, forCellReuseIdentifier: UpcomingMoviesCell.identifer)
        return tableView
    }()
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        interactor?.loadMovies()
    }
    
    // MARK: - Private Functions
    private func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { tableView in
            tableView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            tableView.left.right.equalToSuperview()
            tableView.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func sortFutureMovies(_ movies: [Movie]) -> [Movie] {
        let onlyMoviesWithInformation = movies.filter { $0.posterPathUnwrapped != "" }
        let movieSortedByDate = onlyMoviesWithInformation.sorted(by: { $0.longReleaseDate < $1.longReleaseDate })
        return movieSortedByDate.filter { $0.longReleaseDate > Date() }
    }
}

// MARK: - Extension
extension UpcomingMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingMoviesCell.identifer, for: indexPath) as? UpcomingMoviesCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.showMovieDetails(movie: movies[indexPath.row])
    }
}

extension UpcomingMoviesViewController: UpcomingMoviesSceneOutput {
    func showMovies(viewModel: UpcomingMoviesModels.ViewModel) {
        DispatchQueue.main.async {
            self.movies = self.sortFutureMovies(viewModel.movies)
            self.tableView.reloadData()
        }
    }
    
    func showError(title: String, message: String) {
        DispatchQueue.main.async {
            self.showAlert(title, message, self)
        }
    }
}
