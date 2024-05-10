//
//  CinemaView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct CinemaView: View {
    @State var cinema: Cinema
    @Binding var userAccount: User
    @Binding var isOrdering: Bool
    
    var body: some View{
        VStack {
            
            Text("Choose from the following movies currently showing at \(cinema.name)")
                .font(.headline)
                .padding()
            
            ScrollView {
                ForEach(cinema.getMoviesShown()){ movie in
                    //show sessions after clicking
                    NavigationLink{
                        SessionsView(cinema: cinema, movie: movie, userAccount: $userAccount, isOrdering: $isOrdering)
                    } label: {
                        VStack{
                            MovieView(movie: movie)
                        }
                    }
                }
            }
        }
        .navigationTitle("Movies Showing")
        
    }
    
}


//#Preview {
//    CinemaView()
//}
