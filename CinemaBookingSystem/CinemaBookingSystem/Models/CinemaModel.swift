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
    var sessions: [Session] = []
    
    func getRoomLayout(roomId: Int) -> Layout? {
        for room in self.rooms {
            if room.id == roomId {
                return room.layout
            }
        }
        return nil
    }
    
    mutating func addSession(movie: Movie, time: String) {
        if !sessions.contains(where: { $0.movie.name == movie.name && $0.time == time }) {
            sessions.append(Session(movie: movie, time: time))
            print("Session added: \(movie.name) at \(time) at \(self.name)")
        } else {
            print("Session already exists: \(movie.name) at \(time)")
        }
    }
    
    func getMoviesShown() -> [Movie] {
        var movieSet = Set<Movie>()
        for session in sessions {
            movieSet.insert(session.movie)
        }
        return Array(movieSet)
    }
    
    // Retrieves all sessions for a specific movie
    func getSessions(for movieName: String) -> [Session] {
        return sessions.filter { $0.movie.name == movieName }
    }
    
    // Retrieves all sessions for a specific movie
    func getSessions(for movieId: Int) -> [Session] {
        return sessions.filter { $0.movie.id == movieId }
    }
    
    // Retrieves all sessions for a specific movie
    func getSessions(for movie: Movie) -> [Session] {
        return sessions.filter { $0.movie.id == movie.id }
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
