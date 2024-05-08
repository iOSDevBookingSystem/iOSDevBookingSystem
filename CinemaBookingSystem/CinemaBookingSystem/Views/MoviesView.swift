//
//  MoviesView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct MoviesView: View {
    //@StateObject var viewModel = MoviesViewModel()
    @ObservedObject var viewModel: SchedulesViewModel
    var body: some View {
        ScrollView{
            HStack{
                Text("Movies Showing")
                    .padding(.leading, 7.0)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            ForEach(viewModel.movies.movies){ movie in
                NavigationLink{
                    MovieDetailsView(viewModel: viewModel, movie: movie)
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

#Preview {
    MoviesView(viewModel: SchedulesViewModel())
}
