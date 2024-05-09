//
//  GiftCardModel.swift
//  CinemaBookingSystem
//
//  Created by Tong Qian on 5/5/2024.
//

import Foundation

struct GiftCard: Identifiable, Hashable {
    var id: UUID = UUID()
    var amount: Double
    var expirationDate: Date
    
    // Computed var to check if expired
    var isExpired: Bool {
        expirationDate < Date()
    }
}
