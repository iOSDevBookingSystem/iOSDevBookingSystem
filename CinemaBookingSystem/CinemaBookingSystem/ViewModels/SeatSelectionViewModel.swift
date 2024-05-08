//
//  SeatSelectionViewModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import Foundation

class SeatSelectionViewModel: ObservableObject {
    var cinema: Cinema
    var session: Session
    var tickets: [TicketType: Int]
    
    @Published var seats: [String: [String: Bool]] = [:]
    @Published var selectedSeats: Set<String> = []
    
    // Layout of the cinema room
    var layout: Layout?
    
    // Maximum seats user can select
    var maxSeats: Int

    init(cinema: Cinema, session: Session, tickets: [TicketType: Int]) {
        self.cinema = cinema
        self.session = session
        self.tickets = tickets
        self.maxSeats = tickets.values.reduce(0, +)
        
        // Get the layout of the room
        self.layout = cinema.getRoomLayout(roomId: session.allocatedRoom)
        
        // Generate the seats display
        generateSeats()
        
        // Set seats as taken
        setSeatTaken("A1")
    }


    func generateSeats() {
        if let layout = self.layout {
            for row in 0..<layout.rowCount {
                var rowSeats: [String: Bool] = [:]
                let rowLetter = String(UnicodeScalar("A".unicodeScalars.first!.value + UInt32(row))!)
                let totalSeats = layout.leftSeats + layout.middleSeats + layout.rightSeats

                for number in 1...totalSeats {
                    let seatID = "\(rowLetter)\(number)"
                    rowSeats[seatID] = false  // All seats start as available
                }

                seats[rowLetter] = rowSeats
            }
        }
    }
    
    func toggleSeat(_ seatID: String) {
        if let row = seatID.first.map(String.init), let rowSeats = self.seats[row] {
            if self.selectedSeats.contains(seatID) {
                self.selectedSeats.remove(seatID)
            } else if selectedSeats.count < maxSeats, rowSeats[seatID] == false {
                self.selectedSeats.insert(seatID)
            }
            self.seats[row] = rowSeats
        }
    }
    
    func setSeatTaken(_ seatID: String) {
        if let row = seatID.first.map(String.init), var rowSeats = self.seats[row] {
            rowSeats[seatID] = true
            self.seats[row] = rowSeats
        }
    }
}

