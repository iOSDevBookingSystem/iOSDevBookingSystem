//
//  OrderViewModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 8/5/2024.
//

import Foundation

class OrderViewModel: ObservableObject {
    var cinema: Cinema
    var session: Session
    var tickets: [TicketType: Int]
    var addOns: [any PurchasableItems]
    var userAccount: User
    var selectedSeats: Set<String>
    
    init(cinema: Cinema, session: Session, tickets: [TicketType: Int], userAccount: User, selectedSeats: Set<String>) {
        self.cinema = cinema
        self.session = session
        self.tickets = tickets
        self.addOns = []
        self.userAccount = userAccount
        self.selectedSeats = selectedSeats
    }
    
    func completeOrder() {
        userAccount.orders.append(Order(payment_method: "Card", items: addOns, tickets: generateTickets(), cinema: cinema, session: session))
    }
    
    func generateTickets() -> [Ticket] {
        var generated: [Ticket] = []
        var availableSeats = Array(selectedSeats) // Convert set to array for indexing

        for (type, count) in tickets {
            for _ in 0..<count {
                if !availableSeats.isEmpty {
                    let randomIndex = Int.random(in: 0..<availableSeats.count)
                    let selectedSeat = availableSeats.remove(at: randomIndex) // Remove to avoid duplicates
                    
                    let ticketName = "\(session.movie.name) - \(cinema.name) - \(session.time) - Seat: \(selectedSeat)"
                    let ticket = Ticket(name: ticketName, unit_price: type.price, type: type, session: session)
                    generated.append(ticket)
                }
            }
        }
        return generated
    }
}
