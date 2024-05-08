//
//  MoviesViewModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 1/5/2024.
//

import Foundation

class MoviesViewModel: ObservableObject {
    private var movies: [Movie] = []

    func addMovie(movie: Movie) {
        if !movies.contains(where: { $0.name == movie.name }) {
            movies.append(movie)
            print("Movie added: \(movie.name)")
        } else {
            print("Movie already exists: \(movie.name)")
        }
    }

    func getMovie(name: String) -> Movie? {
        return movies.first { $0.name == name }
    }
    
    func getMovie(id: Int) -> Movie? {
        return movies.first { $0.id == id }
    }
    
    func getMovies() -> [Movie] {
        return movies
    }
    
}
