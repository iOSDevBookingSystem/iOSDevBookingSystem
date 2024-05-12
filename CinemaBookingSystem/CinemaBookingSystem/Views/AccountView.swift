//
//  AccountView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//  Changed by Tong Qian on 5/5/2024.
//

import SwiftUI

struct AccountView: View {
    @Binding var userAccount: User
    @Binding var isLoggedIn: Bool
    @ObservedObject var authViewModel : AuthViewModel

    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink(destination: OrderHistoryView(userAccount: $userAccount)) {
                        Text("My Orders")
                    }
                    
                    NavigationLink(destination: GiftCardsView(userAccount: $userAccount)) {
                        Text("My Gift Cards")
                    }

                    NavigationLink(destination: UserAccountView(userAccount: $userAccount)) {
                        Text("My Personal Details")
                    }

                    NavigationLink(destination: SettingsView(userAccount: userAccount)) {
                        Text("App Settings")
                    }

                }
                    .navigationTitle("My Account")
                    .listStyle(GroupedListStyle())
                    
                
                NavigationLink{
                    ContentView()
                        .onAppear{
                            authViewModel.logout()
                        }
                } label: {
                    Text("Logout")
                        .tint(.red)
                }
                Spacer()
            }
            
            
            
        }
    }
}

//
//#Preview {
//    AccountView(authViewModel: AuthViewModel())
//}
