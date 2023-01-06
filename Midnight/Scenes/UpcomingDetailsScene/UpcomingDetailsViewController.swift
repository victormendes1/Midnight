//
//  UpcomingDetailsViewController.swift
//  Midnight
//
//  Created by Victor Mendes on 15/12/22.
//

import UIKit
import SnapKit

// MARK: - Scene Protocol
protocol UpcomingDetailsSceneInput: AnyObject {
    func loadDetails(request: UpcomingDetailsModels.Request)
}

protocol UpcomingDetailsSceneOutput: AnyObject, Alert {
    func showDetails(viewModel: UpcomingDetailsModels.ViewModel)
    func showError(title: String, message: String)
}

// MARK: - Class
final class UpcomingDetailsViewController: UIViewController {
    var interactor: UpcomingDetailsSceneInput?
    var selectedMovie: Movie = Movie()

    private var similarMovies: [Movie] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UpcomingPosterCell.self, forCellReuseIdentifier: UpcomingPosterCell.identifier)
        tableView.register(SimilarMoviesCell.self, forCellReuseIdentifier: SimilarMoviesCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        interactor?.loadDetails(request: .init(movie: selectedMovie))
    }
    
    // MARK: - Private Functions
    private func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { tableView in
            tableView.width.height.equalToSuperview()
        }
    }
}

// MARK: - Extension
extension UpcomingDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        similarMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellForPoster = tableView.dequeueReusableCell(withIdentifier: UpcomingPosterCell.identifier, for: indexPath) as? UpcomingPosterCell,
              let cellToSimilar = tableView.dequeueReusableCell(withIdentifier: SimilarMoviesCell.identifier, for: indexPath) as? SimilarMoviesCell else { return UITableViewCell() }
        
        if indexPath.row == .zero {
            cellForPoster.configure(selectedMovie)
            return cellForPoster
        } else {
            cellToSimilar.configure(similarMovies[indexPath.row])
            return cellToSimilar
        }
    }
}

extension UpcomingDetailsViewController: UpcomingDetailsSceneOutput {
    func showDetails(viewModel: UpcomingDetailsModels.ViewModel) {
        DispatchQueue.main.async {
            self.selectedMovie.duration = viewModel.featuredMovie.duration
            self.selectedMovie.trailerID = viewModel.trailer
            self.similarMovies = viewModel.similaresMovies
            self.tableView.reloadData()
        }
    }
    
    func showError(title: String, message: String) {
        DispatchQueue.main.async {
            self.showAlert(title, message, self)
        }
    }
}
