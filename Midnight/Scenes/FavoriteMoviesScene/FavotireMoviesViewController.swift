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
    func updateSceneBackground()
    func removeSelectedMovieFromFavorites(id: Int, count: Int)
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
    private var openingAnimation = true
    
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
        interactor?.updateSceneBackground()
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Remove") { [weak self] _, _, _ in
            if let self = self {
                self.interactor?.removeSelectedMovieFromFavorites(id: self.movies[indexPath.row].id, count: self.movies.count)
                self.movies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        return UISwipeActionsConfiguration(actions: [contextItem])
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
        if openingAnimation && !content {
            tableView.isScrollEnabled = false
            emptyListBackgroundView.alpha = 1
            emptyListLabel.alpha = 1
            emptyListBackgroundView.play(fromFrame: 0, toFrame: 190, loopMode: .playOnce) { [weak self] _ in
                guard let self = self else { return }
                self.emptyListBackgroundView.animationSpeed = 0.8
                self.emptyListBackgroundView.play(fromFrame: 190, toFrame: 310, loopMode: .autoReverse)
            }
        } else if !content {
            UIView.animate(withDuration: 0.7, delay: .zero, options: .curveEaseInOut) {
                self.emptyListBackgroundView.alpha = 1
                self.emptyListLabel.alpha = 1
            }
            tableView.isScrollEnabled = false
            emptyListBackgroundView.animationSpeed = 0.8
            emptyListBackgroundView.play(fromFrame: 190, toFrame: 310, loopMode: .autoReverse)
            
        } else {
            tableView.isScrollEnabled = true
            emptyListBackgroundView.alpha = 0
            emptyListLabel.alpha = 0
        }
        openingAnimation = false
    }
}
