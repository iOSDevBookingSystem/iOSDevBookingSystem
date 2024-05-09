//
//  TicketView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 9/5/2024.
//

import SwiftUI

struct TicketView: View {
    var ticket: Ticket

    var body: some View {
        Text("Ticket for: \(ticket.name)")
            .navigationTitle("Ticket Details")
    }
}

//#Preview {
//    TicketView()
//}
