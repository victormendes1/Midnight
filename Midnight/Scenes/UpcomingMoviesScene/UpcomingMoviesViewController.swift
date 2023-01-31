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
    private var filteredMovies: [Movie] = []
    private var searchController = UISearchController()
    
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
        configureSearchBar()
        interactor?.loadMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationControllerDark(title: "Upcoming")
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
    
    private func configureSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchBar.keyboardAppearance = .dark
        navigationItem.searchController = searchController
    }
}

// MARK: - Extension
extension UpcomingMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingMoviesCell.identifer, for: indexPath) as? UpcomingMoviesCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(filteredMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.showMovieDetails(movie: movies[indexPath.row])
    }
}

extension UpcomingMoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = searchText == "" ? movies : movies.filter { (item: Movie) -> Bool in
            return item.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
}

extension UpcomingMoviesViewController: UpcomingMoviesSceneOutput {
    func showMovies(viewModel: UpcomingMoviesModels.ViewModel) {
        DispatchQueue.main.async {
            self.movies = self.sortFutureMovies(viewModel.movies)
            self.filteredMovies = self.movies
            self.tableView.reloadData()
        }
    }
    
    func showError(title: String, message: String) {
        DispatchQueue.main.async {
            self.showAlert(title, message, self)
        }
    }
}
