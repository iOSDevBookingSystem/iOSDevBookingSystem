//
//  MovieDetailsView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 8/5/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var cinemasViewModel : CinemasViewModel
    @ObservedObject var moviesViewModel: MoviesViewModel
    @Binding var userAccount: User
    @Binding var isOrdering: Bool
    @State var movie: Movie
    
    var body: some View {
        ScrollView{
            //show movie details
            VStack{
                Image("\(movie.imageName)")
                    .resizable()
                    .frame(width: 150, height: 200)
                Text(movie.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                Text(movie.genre)
                    .font(.body)
                    .fontWeight(.thin)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                Text(movie.longDescription)
                    .font(.subheadline)
                    .fontWeight(.thin)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
            }
            //navigate to cinemas to purchase tickets
            
            NavigationLink{
                // proceed to select cinema
                CinemaSelectionView(viewModel: cinemasViewModel, userAccount: $userAccount, isOrdering: $isOrdering, movie: movie)
            } label:{
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

//#Preview {
//    MovieDetailsView()
//}
