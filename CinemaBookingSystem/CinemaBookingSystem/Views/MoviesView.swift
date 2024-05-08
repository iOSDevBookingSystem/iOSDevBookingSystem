//
//  MoviesView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

//lists all movies
struct MoviesView: View {
    @ObservedObject var viewModel: MoviesViewModel
    @ObservedObject var cinemasViewModel: CinemasViewModel
    @State var userAccount: User
    
    var body: some View {
        ScrollView{
            HStack{
                Text("Movies Showing")
                    .padding(.leading, 7.0)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            ForEach(viewModel.getMovies()){ movie in
                // click any movie to go to details page
                NavigationLink{
                    MovieDetailsView(cinemasViewModel: cinemasViewModel, moviesViewModel: viewModel, userAccount: userAccount, movie: movie)
                } label: {
                    VStack{
                        MovieView(movie: movie)
//                        ZStack{
//                            Rectangle()
//                                .fill(.black)
//                                .frame(width: 200, height: 30)
//                                .cornerRadius(10.0)
//                            Text("Movie Details")
//                                .foregroundStyle(.white)
//                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    MoviesView(schedulesViewModel: SchedulesViewModel())
//}
