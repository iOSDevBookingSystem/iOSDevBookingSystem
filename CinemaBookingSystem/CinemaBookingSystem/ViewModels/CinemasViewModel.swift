//
//  CinemasViewModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 1/5/2024.
//

import Foundation

class CinemasViewModel: ObservableObject {
    private var cinemas: [Cinema] = []
    
    func addCinema(cinema: Cinema) {
        if !cinemas.contains(where: { $0.name == cinema.name }) {
            cinemas.append(cinema)
            print("Cinema added: \(cinema.name)")
        } else {
            print("Cinema already exists: \(cinema.name)")
        }
    }
    
    func getCinema(name: String) -> Cinema? {
        return cinemas.first { $0.name == name }
    }
    
    func getCinema(id: Int) -> Cinema? {
        return cinemas.first { $0.id == id }
    }
    
    func getCinemas() -> [Cinema] {
        return self.cinemas
    }

    func addSessionToCinema(name: String, movie: Movie, time: String) {
        guard let index = cinemas.firstIndex(where: { $0.name == name }) else {
            print("Cinema not found")
            return
        }
        cinemas[index].addSession(movie: movie, time: time)
    }
