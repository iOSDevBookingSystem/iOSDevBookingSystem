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
    var userAccount: User
    var selectedSeats: Set<String>
    
    @Published var addOns: [ItemType: Int]
    @Published var selectedGiftCards: Set<UUID>
    
    init(cinema: Cinema, session: Session, tickets: [TicketType: Int], userAccount: User, selectedSeats: Set<String>) {
        self.cinema = cinema
        self.session = session
        self.tickets = tickets
        self.addOns = [.regularPopcorn: 0, .largePopcorn: 0, .refillableDrink: 0, .collectableCup: 0]
        self.userAccount = userAccount
        self.selectedSeats = selectedSeats
        self.selectedGiftCards = []
    }
    
    func generateAddOns() -> [ItemType] {
        var generated: [ItemType] = []
        for (type, count) in self.addOns {
            for _ in 0..<count {
                generated.append(type)
            }
        }
        return generated
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
                    
                    // Mark seats as taken
                    self.cinema.appendTakenSeat(to: session.allocatedRoom, seatId: selectedSeat)
                }
            }
        }
        return generated
    }
    
    // Computed var for order total
    var totalOrderAmount: Double {
        let ticketTotal = tickets.reduce(0) { total, ticket in
            total + Double(ticket.value) * ticket.key.price
        }
        let addOnTotal = addOns.reduce(0) { total, item in
            total + Double(item.value) * item.key.details.price
        }
        return ticketTotal + addOnTotal
    }
    
}
