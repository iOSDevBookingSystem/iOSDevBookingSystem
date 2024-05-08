//
//  MovieModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import Foundation
import SwiftUI

struct Movie: Codable, Hashable, Identifiable{
    var id: Int
    var name: String
    var genre: String
    var description: String
    var imageName : String
    //var sessions: [String]
    
    init(id: Int, name: String, genre: String, description: String, imageName: String) {
        self.id = id
        self.name = name
        self.genre = genre
        self.description = description
        self.imageName = imageName
        //self.sessions = sessions
    }
}

//struct Time{
//    
//}

