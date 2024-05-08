//
//  GiftCardView.swift
//  CinemaBookingSystem
//
//  Created by Tong Qian on 5/5/2024.
//



import SwiftUI

struct GiftCardView: View {
    @Binding var userAccount: User

    var body: some View {
        NavigationView {
            List($userAccount.giftCards) { giftCard in
                VStack(alignment: .leading) {
                    Text("Gift Card ID: \(giftCard.id)")
                        .font(.headline)
                    Text("Amount: $\(giftCard.amount)")
                    Text("Expiration Date: \(giftCard.expirationDate)")
                    // todo: other information
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("My Gift Cards")
            //todo: add buy giftcard
        }
    }
}

//#Preview {
//    GiftcardView()
//}
