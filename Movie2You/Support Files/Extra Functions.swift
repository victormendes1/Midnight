//
//  Extra Functions.swift
//  Movie2You
//
//  Created by Victor Mendes on 09/01/22.
//

import Foundation
import UIKit
func mapToMovies(data: (Movie, SimilarMovies, Genres)) -> [Movies] {
    let movies = data.1.movies.map { movie -> Movies in
        Movies(
            mainMovie: data.0,
            backdropPath: movie.backdropPath,
            genres: data.2,
            genreId: movie.genreId,
            id: movie.id,
            originalTitle: movie.originalTitle,
            releaseDate: movie.releaseDate,
            posterPath: movie.posterPath,
            popularity: movie.popularity,
            voteCount: movie.voteCount)
    }
    return movies
}

func getEnvironmentVar(_ name: String) -> String {
    guard let rawValue = getenv(name) else { return "No key found" }
    let toString = String(utf8String: rawValue) ?? "Could not convert key"
    return toString
}

func addShadowTop(_ imageView: StretchyHeaderView, place: UIView, leftButton: UIButton? = nil) {
    let shadow = CAGradientLayer()
    shadow.colors = [UIColor.black.withAlphaComponent(0.8).cgColor , UIColor.clear.cgColor]
    let viewTop = UIView(frame: CGRect(x: 0, y: 0, width: imageView.bounds.width, height: 80))
    shadow.frame = viewTop.frame
    viewTop.layer.addSublayer(shadow)
    place.addSubview(viewTop)
    if let _leftButton = leftButton {
        place.addSubview(_leftButton)
    }
}

func addShadowBottom(_ imageView: StretchyHeaderView) {
    let shadow = CAGradientLayer()
    shadow.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor] // TODO: - Melhorar a forma em que aplico essas cores
    shadow.frame = imageView.frame
    imageView.layer.addSublayer(shadow)
}

func showAlert(_ title: String, _ message: String, _ view: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    view.present(alert, animated: true)
}
