//
//  GenreModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 1/5/2024.
//

import Foundation

// TO-DO: add Codeable
enum GenreList: String, CaseIterable, Hashable {
    case action = "Action"
    case comedy = "Comedy"
    case drama = "Drama"
    case fantasy = "Fantasy"
    case horror = "Horror"
    case romance = "Romance"
    case thriller = "Thriller"
    
    static func allGenres() -> [String] {
        return GenreList.allCases.map { $0.rawValue }
    }
}

// TO-DO: add Codeable
enum CinemaList: String, CaseIterable, Hashable {
    case cinema1 = "Cinema 1"
    case cinema2 = "Cinema 2"
    case cinema3 = "Cinema 3"
    case cinema4 = "Cinema 4"
    
    static func allCinemas() -> [String] {
        return CinemaList.allCases.map { $0.rawValue }
    }
}
