//
//  SchedulesViewModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 1/5/2024.
//

import Foundation

class SchedulesViewModel: ObservableObject {
    private var schedules: [Session] = []
    
    func addSession(movie: Movie, cinema: Cinema, time: String) {
        for session in schedules {
            if session.cinema.id == cinema.id && session.movie.name == movie.name && session.time == time {
                break
            }
            schedules.append(Session(id: 0, cinema: cinema, movie: movie, time: time))
        }
    }
    
    func addSession(session: Session) {
        for saved_session in schedules {
            if saved_session.cinema.id == session.cinema.id && saved_session.movie.name == session.movie.name && saved_session.time == session.time {
                break
            }
            schedules.append(session)
        }
    }
    
    func getSession(movie: Movie, time: String, cinemaId: Int) -> Session? {
        for session in schedules {
            if session.cinema.id == cinemaId && session.movie.name == movie.name && session.time == time {
                return session
            }
        }
        return nil
    }
}
