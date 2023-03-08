//
//  PopularMoviesViewController.swift
//  Midnight
//
//  Created by Victor Mendes on 31/10/22.
//

import UIKit
import SnapKit

// MARK: - Protocol
protocol PopularMoviesViewControllerInput: AnyObject {
    func loadMovies()
    func loadGenres()
    func updateListFavorite()
}

protocol PopularMoviesViewControllerOutput: AnyObject, Alert {
    func showMovies(viewModel: PopularMoviesModels.ViewModel)
    func showError(title: String, message: String)
    func changeStateOfSelectedMovie(_ ids: [Int])
    func showLoading(active: Bool)
}

// MARK: - Class
final class PopularMoviesViewController: UIViewController {
    var interactor: PopularMoviesViewControllerInput?
    var router: PopularMoviesSceneRouter?
    
    private var selectedMovie = Movie()
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    private var searchController = UISearchController()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.size.width * 0.315, height: view.frame.size.height * 0.22)
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
        configureSearchBar()
        interactor?.loadMovies()
        interactor?.loadGenres()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationControllerDark(title: "Popular")
        interactor?.updateListFavorite()
    }
    
    // MARK: - Private Functions
    private func setupViews() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { collectionView in
            collectionView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            collectionView.left.right.equalToSuperview()
            collectionView.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func configureSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.searchTextField.textColor = .white
        //enable delayed searchBar
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.navigationItem.searchController = self.searchController
        })
    }
}

// MARK: - Extension
extension PopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCell.identifer, for: indexPath) as? PopularMovieCell else { return UICollectionViewCell() }
        cell.configure(filteredMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.showMovieDetails(movie: filteredMovies[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (filteredMovies.count - 7) {
            interactor?.loadMovies()
        }
    }
}

extension PopularMoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let attributes =  [NSAttributedString.Key.foregroundColor: UIColor.white]
        searchBar.searchTextField.attributedText = NSAttributedString(string: searchText, attributes: attributes)
        filteredMovies = searchText == "" ? movies : movies.filter { (item: Movie) -> Bool in
            return item.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredMovies = movies
        collectionView.reloadData()
    }
}

// MARK: - Output
extension PopularMoviesViewController: PopularMoviesViewControllerOutput {
    func showMovies(viewModel: PopularMoviesModels.ViewModel) {
        DispatchQueue.main.async {
            self.movies += viewModel.movies
            self.filteredMovies = self.movies
            self.collectionView.reloadData()
        }
    }
    
    func showError(title: String, message: String) {
        self.showAlert(title, message, self)
    }
    
    func changeStateOfSelectedMovie(_ ids: [Int]) {
        self.filteredMovies.forEach { movie in
            if ids.contains(movie.id) {
                movie.liked = true
            }
        }
    }
}
