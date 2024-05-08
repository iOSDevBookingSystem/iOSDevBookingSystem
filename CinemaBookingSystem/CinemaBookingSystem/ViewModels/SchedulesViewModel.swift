//
//  SchedulesViewModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 1/5/2024.
//

import Foundation

class SchedulesViewModel: ObservableObject {
    @Published var schedules: [Session] = []
    @Published var movies: Movies = Movies()
    @Published var cinemas: Cinemas = Cinemas()
//    @Published var movies: MoviesViewModel = MoviesViewModel()
//    @Published var cinemas: CinemasViewModel = CinemasViewModel()
    
    init(){
        //addSession(session: Session(id: 1 , cinema: cinemas.getCinema(id: 1)!, movie: movies.getMovie(id: 0)!, time: "12:00"))
        schedules.append(Session(id: 1 , cinema: cinemas.getCinema(id: 1)!, movie: movies.getMovie(id: 0)!, time: "12:00"))
        schedules.append(Session(id: 2 , cinema: cinemas.getCinema(id: 1)!, movie: movies.getMovie(id: 0)!, time: "13:00"))
        schedules.append(Session(id: 3 , cinema: cinemas.getCinema(id: 1)!, movie: movies.getMovie(id: 1)!, time: "14:00"))
        schedules.append(Session(id: 4 , cinema: cinemas.getCinema(id: 2)!, movie: movies.getMovie(id: 1)!, time: "12:00"))
        schedules.append(Session(id: 5 , cinema: cinemas.getCinema(id: 2)!, movie: movies.getMovie(id: 0)!, time: "13:00"))
        //addSession(movie: movies.getMovie(id: 0)!, cinema: cinemas.getCinema(id: 1)!, time: "13:00")
        //addSession(movie: movies.getMovie(id: 0)!, cinema: cinemas.getCinema(id: 1)!, time: "14:00")
        //addSession(movie: movies.getMovie(id: 0)!, cinema: cinemas.getCinema(id: 1)!, time: "15:00")
        //print(schedules)
    }
    
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
