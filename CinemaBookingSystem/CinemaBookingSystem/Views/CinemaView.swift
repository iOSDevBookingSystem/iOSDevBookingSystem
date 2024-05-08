//
//  CinemaView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct CinemaView: View {
    //@StateObject var viewModel = MoviesViewModel()
    @ObservedObject var viewModel: SchedulesViewModel
    @State var cinema: Cinema
    @State var showSessions = false
    var body: some View{
        ScrollView{
            Text("Movies Shown: ")
                .font(.subheadline)
            ForEach(viewModel.movies.movies){ movie in
                //show sessions after clicking
                NavigationLink{
                    SessionView(viewModel: viewModel, movie: movie, cinema: cinema)
                } label: {
                    VStack{
                        MovieView(movie: movie)
                        ZStack{
                            Rectangle()
                                .fill(.black)
                                .frame(width: 200, height: 30)
                                .cornerRadius(10.0)
                            Text("Get Tickets")
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }.navigationTitle(cinema.name)
    }
    
}

//display for sessions
struct SessionView : View {
    @ObservedObject var viewModel: SchedulesViewModel
    @State var movie: Movie
    @State var cinema: Cinema
    @State var session: String = ""
    //@State var isSelected = false
    var body: some View {
        ScrollView{
            Text("Select session")
            ForEach(viewModel.schedules, id: \.self){ schedule in
                if (schedule.movie.id == movie.id && schedule.cinema.id == cinema.id){
                    //navigate to seat selection
                    NavigationLink{
                        SeatSelectionView(viewModel: SeatSelectionViewModel(session: schedule, maxSeats: 3))
                    } label:{
                        ZStack{
                            Rectangle()
                                .fill(.black)
                                .cornerRadius(6.0)
                                .frame(height: 50)
                            Text(schedule.time)
                                .foregroundColor(.white)
                        }.padding()
                    }
                }
                    
            }
        }
    }
}

//#Preview {
//    CinemaView()
//}
