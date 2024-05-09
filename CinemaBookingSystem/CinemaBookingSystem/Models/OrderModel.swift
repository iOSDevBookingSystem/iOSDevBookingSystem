//
//  OrderModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 1/5/2024.
//

import Foundation


struct Order: Identifiable, Hashable {
    var id: UUID = UUID()
    var payment_method: String
    var items: [ItemType]
    var tickets: [Ticket]
    var cinema: Cinema
    var session: Session
    
    // Implement the Hashable protocol
    static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//// Base protocol for things that can be in an order
//protocol PurchasableItems: Identifiable, Hashable {
//    var id: UUID { get }
//    var type: ItemType { get }
//    var name: String { get }
//    var price: Double { get }
//    var category: String { get }
//    var description: String { get }
//}
//
//// For food and drinks
//struct Consumable: PurchasableItems {
//    var id: UUID = UUID()
//    var type: ItemType
//    var name: String { type.rawValue }
//    var price: Double { type.details.price }
//    var category: String { type.details.category }
//    var description: String { type.details.description }
//}
//
//// For merch
//struct Accessory: PurchasableItems {
//    var id: UUID = UUID()
//    var type: ItemType
//    var name: String { type.rawValue }
//    var price: Double { type.details.price }
//    var category: String { type.details.category }
//    var description: String { type.details.description }
//}

enum ItemType: String, CaseIterable, Hashable {
    case regularPopcorn = "Regular Popcorn"
    case largePopcorn = "Large Popcorn"
    case refillableDrink = "Refillable Drink"
    case collectableCup = "Collectable Cup"

    var details: (price: Double, category: String, description: String) {
        switch self {
        case .regularPopcorn:
            return (price: 7.99, category: "Food", description: "Regular sized popcorn")
        case .largePopcorn:
            return (price: 10.99, category: "Food", description: "Large sized popcorn")
        case .refillableDrink:
            return (price: 3.99, category: "Drink", description: "Self-serve refillable drink")
        case .collectableCup:
            return (price: 16.99, category: "Merchandise", description: "Assorted Marvel superheros collectable cup")
        }
    }
}
