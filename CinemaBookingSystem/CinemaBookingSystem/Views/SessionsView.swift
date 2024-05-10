//
//  SessionsView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 8/5/2024.
//

import SwiftUI

struct SessionsView: View {
    @State var cinema: Cinema
    @State var movie: Movie
    @Binding var userAccount: User
    @Binding var isOrdering: Bool
    
    var body: some View {
        VStack {
            Text("Choose from the list of available sessions for \(movie.name) at \(cinema.name)")
                .font(.headline)
                .padding()
            
            if cinema.getSessions(for: movie).isEmpty {
                // Display a message when there are no sessions
                Text("There are no sessions available for this movie at this cinema.")
                    .font(.title)
                    .padding()
                    .multilineTextAlignment(.center)
            } else {
                // List the session when there are some
                List{
                    ForEach(cinema.getSessions(for: movie)){ session in
                        NavigationLink{
                            TicketSelectionView(cinema: cinema, session: session, userAccount: $userAccount, isOrdering: $isOrdering)
                        }label:{
                            Text(session.time)
                        }
                    }
                }
            }
            
        }
        .navigationTitle("Available Sessions")
        
    }
}

//#Preview {
//    SessionsView()
//}
