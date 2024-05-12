//
//  ContentView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 29/4/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authViewModel: AuthViewModel = AuthViewModel()
    @ObservedObject var cinemasViewModel: CinemasViewModel = CinemasViewModel()
    @ObservedObject var moviesViewModel: MoviesViewModel = MoviesViewModel()

    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                if let user = Binding($authViewModel.userAccount) {
                    TabView {
                        MoviesView(viewModel: moviesViewModel, cinemasViewModel: cinemasViewModel, userAccount: user)
                            .tabItem {
                                Label("Movies", systemImage: "movieclapper.fill")
                            }
                        
                        CinemasView(viewModel: cinemasViewModel, moviesViewModel: moviesViewModel, userAccount: user)
                            .tabItem {
                                Label("Cinemas", systemImage: "tv.fill")
                            }
                        
                        AccountView(userAccount: user, isLoggedIn: $authViewModel.isAuthenticated, viewModel: authViewModel)
                            .tabItem {
                                Label("My Account", systemImage: "person.fill")
                            }
                    }
                    
                } else {
                    // Handle the unexpected case where there's no user but navigation was triggered
                    Text("No user account available.")
                }
            } else {
                AuthView(viewModel: authViewModel)
            }
        }
            .onAppear {
                populate()
            }
            
    }
    
    func populate() {
        // Create gift cards
        let giftCard = GiftCard(amount: 40.00)
        
        // Create users
        var peterParker = User(name: "Peter Parker", email: "peter@spiderman.com", password: "spiderman", phoneNumber: "02 1234 5678", gender: "Male", selectedGenres: Set(["Comedy"]), selectedCinemas:Set(["Sydney City"]))
        var testingUser = User(name: "Testing User", email: "t", password: "t", phoneNumber: "02 1234 5678", gender: "Male", selectedGenres: Set(["Comedy"]), selectedCinemas:Set(["Blacktown"]))

        testingUser.addGiftCard(giftCard)
        authViewModel.register(user: peterParker) {} onFailure: {}
        authViewModel.register(user: testingUser) {} onFailure: {}
        
        // Add cinemas
        let sydneyCinema = Cinema(id: 1, name: "Sydney City", address: "George St", rooms: [Room(id: 1, layout: Layout(leftSeats: 2, middleSeats: 5, rightSeats: 2, rowCount: 10))])
        let blacktownCinema = Cinema(id: 2, name: "Blacktown", address: "Main St", rooms: [Room(id: 1, layout: Layout(leftSeats: 2, middleSeats: 5, rightSeats: 2, rowCount: 10))])
        self.cinemasViewModel.addCinema(cinema: sydneyCinema)
        self.cinemasViewModel.addCinema(cinema: blacktownCinema)
        
        // Add Movies
        let spiderManMovie = Movie(id: 0, name: "Spider-Man", genre: "Comedy", description: "Movie about spiders", longDescription: "Movie about spiders", imageName: "spiderman")
        let ironManMovie = Movie(id: 1, name: "Iron-Man", genre: "Action", description: "Movie about a man in an iron suit", longDescription: "Movie about a man in an iron suit", imageName: "ironman")
        self.moviesViewModel.addMovie(movie: spiderManMovie)
        self.moviesViewModel.addMovie(movie: ironManMovie)
        
        // Add movie sessions
        self.cinemasViewModel.addSessionToCinema(name: "Sydney City", movie: spiderManMovie, time: "15:00")
        self.cinemasViewModel.addSessionToCinema(name: "Sydney City", movie: ironManMovie, time: "18:00")
        self.cinemasViewModel.addSessionToCinema(name: "Blacktown", movie: spiderManMovie, time: "16:00")
        self.cinemasViewModel.addSessionToCinema(name: "Blacktown", movie: ironManMovie, time: "19:00")

    }
}

#Preview {
    ContentView()
}
