//
//  GiftCardModel.swift
//  CinemaBookingSystem
//
//  Created by Tong Qian on 5/5/2024.
//

import Foundation

struct GiftCard: Identifiable, Hashable {
    var id: UUID
    var initialAmount: Double
    var balance: Double
    var expirationDate: Date
    
    init(amount: Double) {
        self.id = UUID()
        self.initialAmount = amount
        self.balance = amount
        // Using Calendar to add 5 years to the current date
        if let expiry = Calendar.current.date(byAdding: .year, value: 5, to: Date()) {
            self.expirationDate = expiry
        } else {
            fatalError("Unable to calculate expiration date")
        }
    }
    
    // Computed var to check if expired
    var isValid: Bool {
        expirationDate < Date() && balance > 0
    }
    
    mutating func spend(amount: Double) {
        if self.isValid {
            print("Error: The gift card is either empty or expired.")
            return
        }
        
        if balance >= amount {
            balance -= amount
            print("Purchase successful! Remaining balance: $\(balance)")
        } else {
            print("Error: Insufficient balance. Available balance: $\(balance)")
        }
    }
}
