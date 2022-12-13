//
//  PopularMoviesViewController.swift
//  Movie2You
//
//  Created by Victor Mendes on 31/10/22.
//

import UIKit
import SnapKit

protocol PopularMoviesViewControllerInput: AnyObject {
    func loadMovies()
    func loadGenres()
}

protocol PopularMoviesViewControllerOutput: AnyObject , Alert {
    func showError(title: String, message: String)
    func showMovies(viewModel: PopularMoviesModels.ViewModel)
}

final class PopularMoviesViewController: UIViewController {
    var interactor: PopularMoviesViewControllerInput?
    var router: PopularMoviesSceneRouter?
    
    private var movies: [Movie] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 123, height: 175)
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .black
        collectionView.register(PopularMovieCell.self, forCellWithReuseIdentifier: PopularMovieCell.identifer)
        return collectionView
    }()
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        interactor?.loadMovies()
        interactor?.loadGenres()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationController(title: "Popular")
    }
    
    // MARK: - Private Functions
    private func setupViews() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { collectionView in
            collectionView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            collectionView.width.bottom.equalToSuperview()
        }
    }
}

// MARK: - Extension
extension PopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCell.identifer, for: indexPath) as? PopularMovieCell else { return UICollectionViewCell() }
        cell.configure(movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.showMovieDetails(movie: movies[indexPath.row])
    }
}

extension PopularMoviesViewController: PopularMoviesViewControllerOutput {
    func showMovies(viewModel: PopularMoviesModels.ViewModel) {
        self.movies = viewModel.movies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showError(title: String, message: String) {
        DispatchQueue.main.async {
            self.showAlert(title, message, self)
        }
        
    }
}
