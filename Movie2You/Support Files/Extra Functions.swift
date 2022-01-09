//
//  Extra Functions.swift
//  Movie2You
//
//  Created by Victor Mendes on 09/01/22.
//

import Foundation

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
