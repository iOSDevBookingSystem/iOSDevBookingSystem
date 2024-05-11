//
//  GenreModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 1/5/2024.
//

import Foundation

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

enum CinemaList: String, CaseIterable, Hashable {
    case sydney = "Sydney City"
    case blacktown = "Blacktown"
    
    static func allCinemas() -> [String] {
        return CinemaList.allCases.map { $0.rawValue }
    }
}
