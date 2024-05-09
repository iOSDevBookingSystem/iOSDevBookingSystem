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
    
    var body: some View {
        VStack {
            
            NavigationView {
                ScrollView{
                    ForEach(viewModel.getMovies()){ movie in
                        NavigationLink{
                            MovieDetailsView(cinemasViewModel: cinemasViewModel, moviesViewModel: viewModel, userAccount: $userAccount, movie: movie)
                        } label: {
                            VStack{
                                MovieView(movie: movie)
                            }
                        }
                    }
                }
                .navigationTitle("Current Movies")   
            }
            
        }
    }
}

//#Preview {
//    MoviesView(schedulesViewModel: SchedulesViewModel())
//}
