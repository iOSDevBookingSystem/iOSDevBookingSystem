//
//  MoviesViewModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 1/5/2024.
//

import Foundation

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    
    init() {
        //self.addMovie(movie: Movie(id: 0, name: "Spider-Man", genre: "Comedy", description: "Movie about spiders", imageName: "spider-man"))
        movies.append(Movie(id: 0, name: "Spider-Man", genre: "Comedy", description: "Movie about spiders", imageName: "spiderman"))
    }

    func addMovie(movie: Movie) {
        for saved_movie in movies {
            if saved_movie.name == movie.name {
                break
            }
            movies.append(movie)
        }
    }

    func getMovie(name: String) -> Movie? {
        for saved_movie in movies {
            if saved_movie.name == name {
                return saved_movie
            }
        }
        return nil
    }
    
    func getMovie(id: Int) -> Movie? {
        for saved_movie in movies {
            if saved_movie.id == id {
                return saved_movie
            }
        }
        return nil
    }
}
