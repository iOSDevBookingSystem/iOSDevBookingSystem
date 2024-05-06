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
    @State var showSessions = false
    var body: some View{
        ScrollView{
            Text(cinema.name)
                .fontWeight(.bold)
                .font(.title)
            Text("Movies Shown: ")
                .font(.subheadline)
            ForEach(viewModel.movies){ movie in
                Button(action: {
                    showSessions = true
                },label: {
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
                }).sheet(isPresented: $showSessions){
                    SessionView(movie: movie, cinema: cinema)
                }
            }
        }
    }
    
}

struct SessionView : View {
    @State var movie: Movie
    @State var cinema: Cinema
    @State var session: String = ""
    @State var isSelected = false
    var body: some View {
        ScrollView{
            Text("Select session")
            ForEach(movie.sessions, id: \.self){ time in
                Button( action: {
                    isSelected.toggle()
                    session = time
                    print(session)
                }, label:{
                    ZStack{
                        Rectangle()
                            .fill(isSelected ? .gray : .black)
                            .cornerRadius(6.0)
                            .frame(height: 50)
                        Text(time)
                            .foregroundColor(isSelected ? .black : .white)
                    }.padding()
                })
            }
            NavigationLink{
                
            } label: {
                
            }
        }
    }
}

//#Preview {
//    CinemaView()
//}
