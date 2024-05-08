//
//  MovieModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import Foundation

struct Movie: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var genre: String
    var description: String
    
    init(id: Int, name: String, genre: String, description: String) {
        self.id = id
        self.name = name
        self.genre = genre
        self.description = description
    }
}

