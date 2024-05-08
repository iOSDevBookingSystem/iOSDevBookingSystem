//
//  ContentView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 29/4/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authViewModel: AuthViewModel = AuthViewModel()
    
    var body: some View {
        if authViewModel.isAuthenticated {
            if let user = authViewModel.userAccount {
                TabView {
                    OrderHistoryView(userAccount: user)
                        .tabItem {
                            Label("Movies", systemImage: "movieclapper.fill")
                        }
                    
                    OrderHistoryView(userAccount: user)
                        .tabItem {
                            Label("Cinemas", systemImage: "tv.fill")
                        }
                    
                    AccountView(userAccount: user, isLoggedIn: $authViewModel.isAuthenticated)
                        .tabItem {
                            Label("Account Settings", systemImage: "gear")
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
}

#Preview {
    ContentView()
}
