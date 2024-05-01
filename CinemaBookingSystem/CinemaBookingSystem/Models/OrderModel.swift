//
//  OrderModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 1/5/2024.
//

import Foundation

// TO-DO: add Codeable
struct Order: Identifiable, Hashable {
    var id: UUID = UUID()
    var payment_method: String
//    var items: [any PurchasableItems]
}

// Base protocol for things that can be in an order
protocol PurchasableItems: Hashable {
    var id: UUID { get }
    var name: String { get }
    var unit_price: Double { get }
    var category: String { get }
}

// For tickets
struct Ticket: PurchasableItems {
    var id: UUID = UUID()
    var name: String
    var unit_price: Double
    var category: String
    var session: Session
}

// For food and drinks
struct Consuable: PurchasableItems {
    var id: UUID = UUID()
    var name: String
    var unit_price: Double
    var category: String
    var description: String
}
