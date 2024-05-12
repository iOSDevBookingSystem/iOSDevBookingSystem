//
//  GiftCardsView.swift
//  CinemaBookingSystem
//
//  Created by Tong Qian on 5/5/2024.
//

import SwiftUI
import Combine

struct GiftCardsView: View {
    @Binding var userAccount: User
    @State private var shouldRefresh: Bool = false // Add shouldRefresh state

    var body: some View {
        NavigationView {
            if userAccount.giftCards.isEmpty {
                // Display a message when there are no gift cards
                Text("You don't have any Gift Cards.")
                    .font(.title)
                    .padding()
                    .multilineTextAlignment(.center)
            } else {
                // List the gift cards when there are some
                List(userAccount.giftCards, id: \.id) { giftCard in
                    VStack(alignment: .leading) {
                        Text("Balance: $\(giftCard.balance, specifier: "%.2f")")
                        Text("Expiration Date: \(giftCard.expirationDate, formatter: dateFormatter)")
                        Text("Gift Card Code: \(giftCard.id.uuidString)")
                    }
                    .padding(.vertical, 8)
                }
                .navigationTitle("My Gift Cards")
            }
        }
        .navigationBarItems(trailing:
            NavigationLink(destination: BuyGiftCardView(userAccount: $userAccount, shouldRefresh: $shouldRefresh)) {
                Text("Get a New Gift Card")
            }
        )
        .onReceive(Just(shouldRefresh)) { refreshed in
                    if refreshed {
                        // Refresh the user account data or any other necessary actions
                        // For example, you may fetch updated user data from a server
                        // Here, we simply reset shouldRefresh to false
                        self.shouldRefresh = false
                    }
                }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
        
    }
}
//
//#Preview {
//    GiftCardsView()
//}
