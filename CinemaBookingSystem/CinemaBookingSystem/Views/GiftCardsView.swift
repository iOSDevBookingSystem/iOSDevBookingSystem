//
//  GiftCardsView.swift
//  CinemaBookingSystem
//
//  Created by Tong Qian on 5/5/2024.
//

import SwiftUI

struct GiftCardsView: View {
    @Binding var userAccount: User

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
            NavigationLink(destination: BuyGiftCardView(userAccount: $userAccount)) {
                Text("Get a New Gift Card")
            }
        )
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
