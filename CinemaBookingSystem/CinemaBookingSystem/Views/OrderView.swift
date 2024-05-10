//
//  OrderView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 10/5/2024.
//

import SwiftUI

struct OrderView: View {
    var order: Order
    
    var body: some View {
        
        Text("Add-ons")
            .font(.headline)
        
        if !order.items.isEmpty {
            ForEach(order.items, id: \.self) { itemType in
                Text("\(itemType.rawValue) - $\(itemType.details.price, specifier: "%.2f")")
            }
        } else {
            Text("No add-ons in this order")
        }
        
        Text("Tickets")
            .font(.headline)

        if !order.tickets.isEmpty {
            ForEach(order.tickets, id: \.id) { ticket in
                NavigationLink(destination: TicketView(ticket: ticket)) {
                    Text("\(ticket.type.rawValue) - \(ticket.name)")
                }
            }
        } else {
            Text("No add-ons in this order")
        }
    }
}

//#Preview {
//    OrderView()
//}
