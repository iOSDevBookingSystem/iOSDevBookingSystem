//
//  MoviesView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var viewModel: MoviesViewModel
    @ObservedObject var cinemasViewModel: CinemasViewModel
    @Binding var userAccount: User
    
    @State var isOrdering: Bool = false
    @State private var selectedMovie: Movie?
    
    var body: some View {
        VStack{
            NavigationView{
                ScrollView{
                    Text("Movies For You: ")
                        .font(.title2)
                    ForEach(viewModel.getMovies()){ movie in
                        if(userAccount.selectedGenres.contains(movie.genre)){
                            Button(action: {
                                selectedMovie = movie
                                isOrdering = true
                            }, label: {
                                MovieView(movie: movie)
                            })
                        }
                    }
                    Text("Other Movies: ")
                        .font(.title2)
                    ForEach(viewModel.getMovies()){ movie in
                        if(!userAccount.selectedGenres.contains(movie.genre)){
                            Button(action: {
                                selectedMovie = movie
                                isOrdering = true
                            }, label: {
                                MovieView(movie: movie)
                            })
                        }
                    }
                }
                .navigationTitle("Movies Showing")
            }
            .fullScreenCover(isPresented: $isOrdering, onDismiss: {
                isOrdering = false
            }) {
                if let movie = selectedMovie{
                    NavigationView{
                        MovieDetailsView(cinemasViewModel: cinemasViewModel, moviesViewModel: viewModel, userAccount: $userAccount, isOrdering: $isOrdering, movie: movie)
                            .toolbar{
                                ToolbarItem(placement: .navigationBarLeading){
                                    Button("Cancel"){
                                        isOrdering = false
                                    }
                                }
                            }
                    }
                }
            }
        }
    }
}

//#Preview {
//    MoviesView(schedulesViewModel: SchedulesViewModel())
//}
