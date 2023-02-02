//
//  Stub.swift
//  MidnightTests
//
//  Created by Victor Mendes on 01/02/23.
//

@testable import Midnight

struct Stub {
    static var movies: [Movie] {
        let movies = [
            Movie(backdropPath: "/faXT8V80JRhnArTAeYXz0Eutpv9.jpg",
                  genreId: [16, 28, 12, 35, 10751, 14],
                  id: 315162,
                  title: "Puss in Boots: The Last Wish",
                  overview: "Puss in Boots discovers that his passion for adventure has taken its toll: He has burned through eight of his nine lives, leaving him with only one life left. Puss sets out on an epic journey to find the mythical Last Wish and restore his nine lives.",
                  release: "2022-12-21",
                  posterPath: "/kuf6dutpsT0vSVehic3EZIqkOBt.jpg",
                  popularity: 0,
                  voteCount: 0,
                  liked: false),
            
            Movie(backdropPath: "/evaFLqtswezLosllRZtJNMiO1UR.jpg",
                  genreId: [878, 12, 28],
                  id: 76600,
                  title: "Avatar: The Way of Water",
                  overview: "Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.",
                  release: "2022-12-21",
                  posterPath: "/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg",
                  popularity: 0,
                  voteCount: 4859,
                  liked: false),
        ]
        return movies
    }
}
