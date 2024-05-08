//
//  SessionsView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 8/5/2024.
//

import SwiftUI

struct SessionsView: View {
    @State var cinema: Cinema
    @State var movie: Movie
    var userAccount: User
    
    var body: some View {
        NavigationView {
            List{
                ForEach(cinema.getSessions(for: movie)){ session in
                    NavigationLink{
                        TicketSelectionView(cinema: cinema, session: session, userAccount: userAccount)
                    }label:{
                        Text(session.time)
                    }
                }
            }
            .navigationTitle("Cinemas")
        }
        
        
//        ScrollView{
//            Text("Select session for \(movie.name)")
//            ForEach(cinema.getSessions(for: movie), id: \.self){ session in
//                Text("\(session.time)")
//                if (schedule.movie.id == movie.id && schedule.cinema.id == cinema.id){
//                    //navigate to seat selection
//                    NavigationLink{
//                        SeatSelectionView(viewModel: SeatSelectionViewModel(session: schedule, maxSeats: 3))
//                    } label:{
//                        ZStack{
//                            Rectangle()
//                                .fill(.black)
//                                .cornerRadius(6.0)
//                                .frame(height: 50)
//                            Text(schedule.time)
//                                .foregroundColor(.white)
//                        }.padding()
//                    }
//                }
//                    
//            }
//        }
    }
}

//#Preview {
//    SessionsView()
//}
