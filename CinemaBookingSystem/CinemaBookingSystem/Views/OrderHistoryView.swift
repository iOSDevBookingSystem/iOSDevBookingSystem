//
//  OrderHistoryView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct OrderHistoryView: View {
    @Binding var userAccount: User
    @State private var showCancellationAlert = false
    @State private var orderToCancel: Order?

    var body: some View {
        Group {
            if userAccount.orders.isEmpty {
                Text("You don't have any orders.")
                    .font(.title)
                    .padding()
                    .multilineTextAlignment(.center)
            } else {
                List(userAccount.orders, id: \.id) { order in
                    VStack(alignment: .leading) {
                        NavigationLink(destination: OrderView(order: order)) {
                            VStack(alignment: .leading) {
                                Text("Order \(order.id)")
                                    .font(.headline)
                                    .padding()
                                
                                Text("\(order.session.movie.name) at \(order.cinema.name)")
                                    .font(.subheadline)
                                    .padding()
                                
                                Text("Session: \(order.session.time)")
                                    .font(.subheadline)
                                    .padding()
                            }
                        }
                        Button("Cancel Order") {
                            orderToCancel = order
                            showCancellationAlert = true
                        }
                        .padding()
                        .foregroundColor(.red)
                        .buttonStyle(PlainButtonStyle()) // Ensures the button does not interfere with the navigation link
                    }
                }
            }
        }
        .alert(isPresented: $showCancellationAlert) {
            Alert(
                title: Text("Confirm Cancellation"),
                message: Text("Are you sure you want to cancel this order? If you paid by a Gift Card you will be issued another Gift Card for that amount. Amounts charged to a credit card will go back to that account."),
                primaryButton: .destructive(Text("Confirm")) {
                    if let order = orderToCancel {
                        cancelOrder(order)
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }

    private func cancelOrder(_ order: Order) {
        // Refund
        let refundToCard = order.paymentBreakdown["Card"] ?? 0
        
        let refundToGiftCard = order.paymentBreakdown["GiftCard"] ?? 0
        if refundToGiftCard > 0 {
            userAccount.addGiftCard(GiftCard(amount: refundToGiftCard))
        }
        
        if let index = userAccount.orders.firstIndex(where: { $0.id == order.id }) {
            userAccount.orders.remove(at: index)
        }
        
        // Reset order to cancel
        orderToCancel = nil
    }
}


//#Preview {
//    OrderHistoryView()
//}
