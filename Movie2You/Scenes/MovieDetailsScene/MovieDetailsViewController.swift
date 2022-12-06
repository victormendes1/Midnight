//
//  MovieDetailsViewController.swift
//  Movie2You
//
//  Created by Victor Mendes on 31/10/22.
//

import UIKit
import SnapKit

// MARK: - Protocol
protocol MovieDetailsViewControllerIntput: AnyObject {
    func getMovieDetails(request: MovieDetailsModels.Request)
}

protocol MovieDetailsViewControllerOutput: AnyObject {
    func showMainMovie(movie: Movie)
    func showPoster(poster: UIImageView)
    func showSimilarMovies(movies: [Movie])
}

// MARK: - Class
final class MovieDetailsViewController: UIViewController, Alert {
    private var similarMovies: [Movie] = []
    private var selectedMovie: Movie = Movie()
    
    var selectedMovieId: String = ""
    
    var interactor: MovieDetailsViewControllerIntput?
    
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
        setupViews()
        interactor?.getMovieDetails(request: MovieDetailsModels.Request(movieID: selectedMovieId))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationController()
    }
    
    // MARK: - Private Functions
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
        similarMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mainCell = tableView.dequeueReusableCell(withIdentifier: MainMovieCell.identifier, for: indexPath) as? MainMovieCell, let similarCell = tableView.dequeueReusableCell(withIdentifier: SimilarMoviesCell.identifier, for: indexPath) as? SimilarMoviesCell else { return UITableViewCell() }
        
        switch indexPath.row {
        case .zero:
            mainCell.configure(selectedMovie)
            return mainCell
            
        default:
            similarCell.configure(similarMovies[indexPath.row])
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

// MARK: - Extension Ouput
extension MovieDetailsViewController: MovieDetailsViewControllerOutput {
    func showMainMovie(movie: Movie) {
        self.selectedMovie = movie
        self.tableView.reloadData()
    }
    
    func showPoster(poster: UIImageView) {
        self.configureHeaderView(poster)
        self.tableView.reloadData()
    }
    
    func showSimilarMovies(movies: [Movie]) {
        self.similarMovies = movies
        self.tableView.reloadData()
    }
}
