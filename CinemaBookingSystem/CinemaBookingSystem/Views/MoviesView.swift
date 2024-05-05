//
//  MoviesView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct MoviesView: View {
    @StateObject var viewModel = MoviesViewModel()
    var body: some View {
        
        ScrollView{
            HStack{
                Text("Movies Showing")
                    .padding(.leading, 7.0)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            ForEach(viewModel.movies){ movie in
                MovieView(movie: movie)
            }
        }
    }
}

#Preview {
    MoviesView()
}
