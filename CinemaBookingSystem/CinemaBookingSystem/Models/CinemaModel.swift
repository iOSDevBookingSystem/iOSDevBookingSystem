//
//  CinemaModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import Foundation

struct Cinema: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var address: String
    var rooms: [Room]
    
    func getRoomLayout(roomId: Int) -> Layout? {
        for room in self.rooms {
            if room.id == roomId {
                return room.layout
            }
        }
        return nil
    }
}

struct Room: Codable, Hashable {
    var id: Int
    var layout: Layout
}

struct Layout: Codable, Hashable {
    var leftSeats: Int
    var middleSeats: Int
    var rightSeats: Int
    var rowCount: Int
}
