//
//  MainView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @ObservedObject var schedViewModel : SchedulesViewModel
    var body: some View {
        TabView {
            MoviesView(viewModel: schedViewModel)
                .tabItem {
                    Label("Movies", systemImage: "movieclapper.fill")
                }
            
            CinemasView(viewModel: schedViewModel)
                .tabItem {
                    Label("Cinemas", systemImage: "tv.fill")
                }
            
            AccountView(mainViewModel: viewModel)
                .tabItem {
                    Label("Account Settings", systemImage: "gamecontroller.fill")
                }
        }
            .navigationBarBackButtonHidden(true)  // Hides the back button
            .navigationBarHidden(true)            // Hides the entire navigation bar
            .navigationTitle("Main Page")
    }
}
//struct MainView: View {
//    @ObservedObject var viewModel: MainViewModel
//    @Binding var isLoggedIn: Bool
//    
//    var body: some View {
//        TabView {
//            OrderHistoryView(mainViewModel: viewModel)
//                .tabItem {
//                    Label("Movies", systemImage: "movieclapper.fill")
//                }
//            
//            OrderHistoryView(mainViewModel: viewModel)
//                .tabItem {
//                    Label("Cinemas", systemImage: "tv.fill")
//                }
//            
//            AccountView(mainViewModel: viewModel, isLoggedIn: $isLoggedIn)
//                .tabItem {
//                    Label("Account Settings", systemImage: "gamecontroller.fill")
//                }
//        }
//            .navigationBarBackButtonHidden(true)  // Hides the back button
//            .navigationBarHidden(true)            // Hides the entire navigation bar
//            .navigationTitle("Main Page")
//    }
//}

//#Preview {
//    MainView(viewModel: MainViewModel(user: <#T##User#>))
//}
