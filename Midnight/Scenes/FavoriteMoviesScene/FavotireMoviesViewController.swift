//
//  FavotireMoviesViewController.swift
//  Midnight
//
//  Created by Victor Mendes on 28/01/23.
//

import UIKit
import Lottie

// MARK: - Protocol
protocol FavoriteMoviesViewControllerInput: AnyObject {
    func loadFavoriteMovies()
    func updateFavoriteMoviesList(_ moviesCount: Int)
    func updateSceneBackground(_ moviesCount: Int)
}

protocol FavoriteMoviesViewControllerOutput: AnyObject, Alert {
    func showMovies(viewModel: PopularMoviesModels.ViewModel)
    func showError(title: String, message: String)
    func showSceneEmpty(has content: Bool)
}

// MARK: - Class
final class FavotireMoviesViewController: UIViewController {
    private let emptyListBackgroundView = LottieAnimationView(name: "emptyListAnimation")
    private var movies = [Movie]()
    
    private let emptyListLabel: UILabel = {
        let label = UILabel()
        label.text = "You don't have a favorite movie yet"
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .poppins(type: .Bold, size: 18)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.register(UpcomingMoviesCell.self, forCellReuseIdentifier: UpcomingMoviesCell.identifer)
        return tableView
    }()
    
    var interactor: FavoriteMoviesViewControllerInput?
    
    // MARK: -  Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        interactor?.loadFavoriteMovies()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.updateFavoriteMoviesList(movies.count)
        interactor?.updateSceneBackground(movies.count)
    }
    
    // MARK: - Private
    private func setupViews() {
        view.addSubview(tableView)
        tableView.addSubview(emptyListBackgroundView)
        tableView.addSubview(emptyListLabel)
        
        tableView.snp.makeConstraints { tableView in
            tableView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            tableView.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            tableView.width.equalToSuperview()
        }
        
        emptyListBackgroundView.snp.makeConstraints { backgroundImage in
            backgroundImage.centerX.equalToSuperview()
            backgroundImage.centerY.equalToSuperview().offset(-25)
            backgroundImage.width.height.equalTo(200)
        }
        
        emptyListLabel.snp.makeConstraints { text in
            text.centerX.equalTo(emptyListBackgroundView)
            text.top.equalTo(emptyListBackgroundView.snp_bottomMargin)
            text.left.right.equalToSuperview().inset(16)
        }
    }
}

// MARK: - Extension
extension FavotireMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingMoviesCell.identifer, for: indexPath) as? UpcomingMoviesCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(movies[indexPath.row])
        return cell
    }
}

extension FavotireMoviesViewController: FavoriteMoviesViewControllerOutput {
    func showMovies(viewModel: PopularMoviesModels.ViewModel) {
        DispatchQueue.main.async {
            self.movies = viewModel.movies
            self.tableView.reloadData()
        }
    }
    
    func showError(title: String, message: String) {
        DispatchQueue.main.async {
            self.showAlert(title, message, self)
        }
    }
    
    func showSceneEmpty(has content: Bool) {
        if content {
            emptyListBackgroundView.isHidden = true
            emptyListLabel.isHidden = true
        } else {
            emptyListBackgroundView.isHidden = false
            emptyListLabel.isHidden = false
            emptyListBackgroundView.play()
        }
    }
}
