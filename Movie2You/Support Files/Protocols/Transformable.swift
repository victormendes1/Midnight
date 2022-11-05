//
//  Transformable.swift
//  Movie2You
//
//  Created by Victor Mendes on 04/11/22.
//

import Foundation

protocol Transformable {
    func mapToMovies(_ data: (Movie, SimilarMovies, Genres)) -> [Movies]
}

extension Transformable {
    //To handle multiple objects in tableview + rx i needed to merge all types into just one.
    func mapToMovies(_ data: (Movie, SimilarMovies, Genres)) -> [Movies] {
        let movies = data.1.movies.map { movie -> Movies in
            Movies(
                mainMovie: data.0,
                backdropPath: movie.backdropPath ?? "",
                genres: data.2,
                genreId: movie.genreId ?? [],
                id: movie.id,
                originalTitle: movie.originalTitle,
                releaseDate: movie.releaseDate,
                posterPath: movie.posterPath,
                popularity: movie.popularity,
                voteCount: movie.voteCount)
        }
        return movies
    }
}
