//
//  AccountView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var mainViewModel: MainViewModel
    @State var logout: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                List {

                    NavigationLink(destination: OrderHistoryView(mainViewModel: mainViewModel)) {
                        Text("My Orders")
                    }

                    NavigationLink(destination: UserAccountView(mainViewModel: mainViewModel)) {
                        Text("My Personal Details")
                    }

                    NavigationLink(destination: SettingsView(mainViewModel: mainViewModel)) {
                        Text("App Settings")
                    }

                    Button("Logout") {
                        logout = true
                    }
                }
                
            }
            .navigationTitle("My Account")
            .listStyle(GroupedListStyle())
            .navigationDestination(isPresented: $logout) {
                AuthView(viewModel: AuthViewModel(), schedViewModel: SchedulesViewModel())
            }
        }
    }
}

//
//#Preview {
//    AccountView(authViewModel: AuthViewModel())
//}
