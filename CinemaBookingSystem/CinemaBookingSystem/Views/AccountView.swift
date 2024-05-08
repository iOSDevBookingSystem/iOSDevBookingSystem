//
//  AccountView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//  Changed by Tong Qian on 5/5/2024.
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
                    
                    NavigationLink(destination: GiftcardView(mainViewModel: mainViewModel)) {
                        Text("My Giftcard")
                    }

                    NavigationLink(destination: UserAccountView(userAccount: $userAccount)) {
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
