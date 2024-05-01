//
//  AccountView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct AccountView: View {
    @State var userAccount: User
    @Binding var isLoggedIn: Bool

    var body: some View {
        NavigationView {
            VStack {
                List {

                    NavigationLink(destination: OrderHistoryView(userAccount: userAccount)) {
                        Text("My Orders")
                    }

                    NavigationLink(destination: UserAccountView(userAccount: userAccount)) {
                        Text("My Personal Details")
                    }

                    NavigationLink(destination: SettingsView(userAccount: userAccount)) {
                        Text("App Settings")
                    }

                    Button("Logout") {
                        isLoggedIn = false
                    }
                }
                
            }
            .navigationTitle("My Account")
            .listStyle(GroupedListStyle())
        }
    }
}

//
//#Preview {
//    AccountView(authViewModel: AuthViewModel())
//}
