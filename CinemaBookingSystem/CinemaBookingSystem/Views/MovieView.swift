//
//  MovieView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI


//movie preview display
struct MovieView: View {
    @State var movie : Movie
    var body: some View {
        VStack{
            Image("\(movie.imageName)")
                .resizable()
                .frame(width: 150, height: 200)
            Text(movie.name)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.black)
            Text(movie.description)
                .font(.subheadline)
                .fontWeight(.thin)
                .foregroundColor(.black)
        }
    }
}
//#Preview {
//    MovieView()
//}
