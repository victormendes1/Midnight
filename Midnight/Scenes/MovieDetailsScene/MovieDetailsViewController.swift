//
//  MovieDetailsViewController.swift
//  Midnight
//
//  Created by Victor Mendes on 31/10/22.
//

import UIKit
import SnapKit

// MARK: - Protocol
protocol MovieDetailsViewControllerIntput: AnyObject {
    func loadMovieDetails(request: MovieDetailsModels.Request)
    func updateMovieStatus(_ movie: Movie)
    func addFavoriteMovieList(_ movie: Movie)
    func removeFavoriteMovieList(_ movie: Movie)
}

protocol MovieDetailsViewControllerOutput: AnyObject {
    func showDetails(viewModel: MovieDetailsModels.ViewModel)
    func showError(title: String, message: String)
    func showLoading(active: Bool)
    func currentMovieChangedStatus(liked: Bool)
}

// MARK: - Class
final class MovieDetailsViewController: UIViewController, Alert {
    private var similarMovies: [Movie] = []
    var selectedMovie: Movie = Movie()
    
    var interactor: MovieDetailsViewControllerIntput?
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.tableHeaderView = UIView()
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
        interactor?.loadMovieDetails(request: .init(movie: selectedMovie))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationControllerTransparent()
        interactor?.updateMovieStatus(selectedMovie)
    }
    
    // MARK: - Private Functions
    private func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { tableView in
            tableView.top.equalToSuperview()
            tableView.left.right.equalToSuperview()
            tableView.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func configureHeaderView(_ imageView: UIImageView) {
        let headerView = StretchyHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height / 1.5))
        headerView.alpha = 0
        headerView.imageView.image = imageView.image
        addShadowTop(place: self.view)
        addShadowBottom(headerView)
        self.tableView.tableHeaderView = headerView
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
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
        
        mainCell.delegate = self
        
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
        guard let headerView = self.tableView.tableHeaderView as? StretchyHeaderView, let navigationBar = navigationController?.navigationBar else { return }
        headerView.scrollViewDidScroll(scrollView: tableView)
        
        if !navigationBar.isHidden {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - Extension Ouput
extension MovieDetailsViewController: MovieDetailsViewControllerOutput {
    func showDetails(viewModel: MovieDetailsModels.ViewModel) {
        self.similarMovies = viewModel.similarMovies
        DispatchQueue.main.async {
            self.configureHeaderView(viewModel.posterImage)
            self.tableView.reloadData()
        }
    }
    
    func showError(title: String, message: String) {
        DispatchQueue.main.async {
            self.showAlert(title, message, self)
        }
    }
    
    func currentMovieChangedStatus(liked: Bool) {
        selectedMovie.liked = liked
        self.tableView.reloadData()
    }
}

extension MovieDetailsViewController: MovieFavoriteEventDelegate {
    func favoriteMovie(liked: Bool) {
        liked ? self.interactor?.addFavoriteMovieList(selectedMovie) : self.interactor?.removeFavoriteMovieList(selectedMovie)
    }
}
