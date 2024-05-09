//
//  TicketModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 8/5/2024.
//

import Foundation

struct Ticket {
    var id: UUID = UUID()
    var name: String
    var unit_price: Double
    var type: TicketType
    var session: Session
}

enum TicketType: String, CaseIterable {
    case adult = "Adult"
    case child = "Child"
    case student = "Student"
    case concession = "Concession"

    var price: Double {
        switch self {
        case .adult:
            return 15.00
        case .child:
            return 7.50
        case .student:
            return 12.00
        case .concession:
            return 10.00
        }
    }
}
