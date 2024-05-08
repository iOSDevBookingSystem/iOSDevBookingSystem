//
//  CinemaView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

//import SwiftUI
//
////display for sessions
//struct SessionView: View {
////    @ObservedObject var moviesViewModel: MoviesViewModel
////    @ObservedObject var cinemasViewModel: CinemasViewModel
////    
////    @State var movie: Movie
////    @State var cinema: Cinema
////    @State var session: String = ""
////    //@State var isSelected = false
////    var body: some View {
////        ScrollView{
////            Text("Select session")
////            ForEach(getAllSessions(), id: \.self){ schedule in
////                Text("\(schedule.time)")
//////                if (schedule.movie.id == movie.id && schedule.cinema.id == cinema.id){
//////                    //navigate to seat selection
//////                    NavigationLink{
//////                        SeatSelectionView(viewModel: SeatSelectionViewModel(session: schedule, maxSeats: 3))
//////                    } label:{
//////                        ZStack{
//////                            Rectangle()
//////                                .fill(.black)
//////                                .cornerRadius(6.0)
//////                                .frame(height: 50)
//////                            Text(schedule.time)
//////                                .foregroundColor(.white)
//////                        }.padding()
//////                    }
//////                }
////                    
////            }
////        }
////    }
////    
////    func getAllSessions() -> [Session] {
////        // Loop over movies and compile sessions
////        return []
////    }
//}
