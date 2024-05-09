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
        List(userAccount.orders, id: \.self) { order in
            VStack(alignment: .leading) {
                Text("Order \(order.id)")
                    .font(.headline)
                Text("Session: \(order.session.movie.name) at \(order.cinema.name)")
                    .font(.subheadline)

                if !order.items.isEmpty {
                    Text("Add-ons:")
                        .font(.caption)
                    ForEach(order.items, id: \.self) { itemType in
                        Text("\(itemType.rawValue) - $\(itemType.details.price, specifier: "%.2f")")
                    }
                }

                if !order.tickets.isEmpty {
                    Text("Tickets:")
                        .font(.caption)
                    ForEach(order.tickets, id: \.id) { ticket in
                        NavigationLink(destination: TicketView(ticket: ticket)) {
                            Text("\(ticket.type.rawValue) - \(ticket.name)")
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
