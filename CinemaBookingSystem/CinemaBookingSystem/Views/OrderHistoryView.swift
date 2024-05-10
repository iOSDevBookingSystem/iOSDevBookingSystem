//
//  OrderHistoryView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct OrderHistoryView: View {
    @Binding var userAccount: User

    var body: some View {
        if userAccount.orders.isEmpty {
            // Display a message when there are no orders
            Text("You don't have any orders.")
                .font(.title)
                .padding()
                .multilineTextAlignment(.center)
        } else {
            // List the orders when there are some
            List(userAccount.orders, id: \.self) { order in
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
                }
            }
        }
    }
}


//#Preview {
//    OrderHistoryView()
//}
