//
//  SessionModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import Foundation

struct Session: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var movie: Movie
    var time: String
    var allocatedRoom: Int
    
    init(movie: Movie, time: String) {
        self.movie = movie
        self.time = time
        self.allocatedRoom = 1
    }
}
