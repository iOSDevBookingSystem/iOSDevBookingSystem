//
//  OrderModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 1/5/2024.
//

import Foundation


struct Order: Identifiable {
    var id: UUID = UUID()
    var payment_method: String
    var items: [any PurchasableItems]
    var tickets: [Ticket]
    var cinema: Cinema
    var session: Session
}

// Base protocol for things that can be in an order
protocol PurchasableItems: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var unit_price: Double { get }
    var category: String { get }
}

// For food and drinks
struct Consuable: PurchasableItems {
    var id: UUID = UUID()
    var name: String
    var unit_price: Double
    var category: String
    var description: String
}
