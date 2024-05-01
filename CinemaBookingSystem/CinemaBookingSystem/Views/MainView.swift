//
//  MainView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        TabView {
            OrderHistoryView(mainViewModel: viewModel)
                .tabItem {
                    Label("Movies", systemImage: "movieclapper.fill")
                }
            
            OrderHistoryView(mainViewModel: viewModel)
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

//#Preview {
//    MainView(viewModel: MainViewModel(user: <#T##User#>))
//}
