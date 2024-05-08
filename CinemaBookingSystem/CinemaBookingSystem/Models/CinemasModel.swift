//
//  CinemasModel.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 7/5/2024.
//

import Foundation
class Cinemas{
    var cinemas: [Cinema] = []
    init() {
        cinemas.append(Cinema(id: 1, name: "Sydney City", address: "George St", rooms: [Room(id: 1, layout: Layout(leftSeats: 2, middleSeats: 5, rightSeats: 2, rowCount: 10))]))
        cinemas.append(Cinema(id: 2, name: "Blacktown", address: "Main St", rooms: [Room(id: 1, layout: Layout(leftSeats: 2, middleSeats: 5, rightSeats: 2, rowCount: 10))]))
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
