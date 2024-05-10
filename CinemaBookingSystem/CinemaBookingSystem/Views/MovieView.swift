//
//  MovieView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct MovieView: View {
    @State var movie : Movie
    var body: some View {
        HStack{
            Image("\(movie.imageName)")
                .resizable()
                .frame(width: 100, height: 150)
        
            VStack {
                Text(movie.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                Text(movie.description)
                    .font(.subheadline)
                    .fontWeight(.thin)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                Text(movie.longDescription)
                    .font(.subheadline)
                    .fontWeight(.thin)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.trailing)

        }
        .padding()
    }
}

#Preview {
    let spiderManMovie = Movie(id: 0, name: "Spider-Man", genre: "Comedy", description: "Movie about spiders", longDescription: "Movie about spiders", imageName: "spiderman")
    
    return MovieView(movie: spiderManMovie)
}
