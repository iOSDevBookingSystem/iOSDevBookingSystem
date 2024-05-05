//
//  GiftcardModel.swift
//  CinemaBookingSystem
//
//  Created by Tong Qian on 5/5/2024.
//

import Foundation


struct Giftcard: Identifiable, Hashable {
    var id: String
    var amount: Double
    var expirationDate: Date
}
