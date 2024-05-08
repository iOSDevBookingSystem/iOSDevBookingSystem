//
//  CinemaView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct CinemaView: View {
    @State var cinema: Cinema
    var userAccount: User
    
    var body: some View{
        Text("Cinema")
        ScrollView{
            Text("Movies Shown: ")
                .font(.subheadline)
            ForEach(cinema.getMoviesShown()){ movie in
                //show sessions after clicking
                NavigationLink{
                    SessionsView(cinema: cinema, movie: movie, userAccount: userAccount)
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


//#Preview {
//    CinemaView()
//}
