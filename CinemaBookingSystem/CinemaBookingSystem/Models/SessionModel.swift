//
//  SessionModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import Foundation

struct Session: Codable, Hashable {
    var id: Int
    var cinema: Cinema
    var movie: Movie
    var time: String
    var allocatedRoom: Int
    
    init(id: Int, cinema: Cinema, movie: Movie, time: String) {
        self.id = id
        self.cinema = cinema
        self.movie = movie
        self.time = time
        self.allocatedRoom = 1
    }
}
