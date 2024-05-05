//
//  CinemasViewModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 1/5/2024.
//

import Foundation

class CinemasViewModel: ObservableObject {
    @Published var cinemas: [Cinema] = []
    
    init() {
        //self.addCinema(cinema: Cinema(id: 1, name: "Sydney City", address: "George St", rooms: [Room(id: 1, layout: Layout(leftSeats: 2, middleSeats: 5, rightSeats: 2, rowCount: 10))]))
        cinemas.append(Cinema(id: 1, name: "Sydney City", address: "George St", rooms: [Room(id: 1, layout: Layout(leftSeats: 2, middleSeats: 5, rightSeats: 2, rowCount: 10))]))
    }
    
    func addCinema(cinema: Cinema) {
        for saved_cinema in cinemas {
            if saved_cinema.name == cinema.name {
                break
            }
            cinemas.append(cinema)
        }
    }
    
    func getCinema(name: String) -> Cinema? {
        for saved_cinema in cinemas {
            if saved_cinema.name == name {
                return saved_cinema
            }
        }
        return nil
    }
    
    func getCinema(id: Int) -> Cinema? {
        for saved_cinema in cinemas {
            if saved_cinema.id == id {
                return saved_cinema
            }
        }
        return nil
    }
}

