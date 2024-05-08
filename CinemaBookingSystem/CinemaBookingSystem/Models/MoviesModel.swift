//
//  MoviesModel.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 7/5/2024.
//

import Foundation
struct Movies{
    var movies: [Movie] = []
    init(){
        movies.append(Movie(id: 0, name: "Spider-Man", genre: "Comedy", description: "Movie about spiders", imageName: "spiderman"))
        movies.append(Movie(id: 1, name: "Iron-Man", genre: "Action", description: "Movie about a man in an iron suit", imageName: "ironman"))
    }
    
    func getMovie(id: Int) -> Movie? {
        for movie in movies{
            if movie.id == id{
                return movie
            }
        }
        return nil
    }
    
    func getMovie(name: String) -> Movie?{
        for movie in movies{
            if movie.name == name{
                return movie
            }
        }
        return nil
    }
}
