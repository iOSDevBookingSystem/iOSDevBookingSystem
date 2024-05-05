//
//  CinemaView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct CinemaView: View {
    @StateObject var viewModel = MoviesViewModel()
    @State var cinema: Cinema
    var body: some View{
        ScrollView{
            Text(cinema.name)
                .fontWeight(.bold)
                .font(.title)
            Text("Movies Shown: ")
                .font(.subheadline)
            ForEach(viewModel.movies){ movie in
                NavigationLink{
                    CinemasView()
                }label: {
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
        }
    }
    
}

//#Preview {
//    CinemaView()
//}
