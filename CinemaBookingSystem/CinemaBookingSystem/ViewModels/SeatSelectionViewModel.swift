//
//  SeatSelectionViewModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import Foundation

class SeatSelectionViewModel: ObservableObject {
    @Published var session: Session
    
    @Published var seats: [String: [String: Bool]] = [:]
    @Published var selectedSeats: Set<String> = []
    
    var layout: Layout?
    
    var maxSeats: Int  // Maximum seats user can select

    init(session: Session, maxSeats: Int) {
        self.session = session
        self.maxSeats = maxSeats
        
        // Get the layout of the room
        self.layout = session.cinema.getRoomLayout(roomId: session.allocatedRoom)
        
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



