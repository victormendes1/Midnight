//
//  Transformable.swift
//  Movie2You
//
//  Created by Victor Mendes on 04/11/22.
//

import Foundation
import RxRelay

protocol Transformable {
    var movies: BehaviorRelay<[Movie]> { get }
    
    func addGenres(genres: [Genre]) -> [Movie]
}

extension Transformable {
    func addGenres(genres: [Genre]) -> [Movie] {
        let transformedMovies: [Movie] = movies.value.map { movie in
            Movie(
                backdropPath: movie.backdropPath ?? "",
                genres: genres,
                genreId: movie.genreId ?? [],
                id: movie.id,
                originalTitle: movie.originalTitle,
                release: movie.releaseDate,
                posterPath: movie.posterPath,
                popularity: movie.popularity,
                voteCount: movie.voteCount)
        }
        return transformedMovies
    }
}
