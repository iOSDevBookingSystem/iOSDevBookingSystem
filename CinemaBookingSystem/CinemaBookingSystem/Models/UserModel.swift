//
//  UserModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//  Changed by Tong Qian on 5/5/2024.
//

import Foundation

// TO-DO: add Codeable
struct User: Identifiable {
    let id: UUID
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var phoneNumber: String = ""
    var gender: String = ""
    var selectedGenres: Set<String> = []
    var selectedCinemas: Set<String> = []
    var orders: [Order]
    var giftCards: [GiftCard]
    
    init(name: String, email: String, password: String, phoneNumber: String, gender: String, selectedGenres: Set<String>, selectedCinemas: Set<String>) {
        self.id = UUID()
        self.name = name
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.selectedGenres = selectedGenres
        self.selectedCinemas = selectedCinemas
        self.orders = []
        self.giftCards = []
    }
    
    func getName() -> String {
        return self.name
    }
    
//    func updateProfile(name: String, email: String, password: String, phoneNumber: String, gender: String, selectedGenres: Set<String>, selectedCinemas: Set<String>) {
//        self.name = name
//        self.email = email
//        self.password = password
//        self.phoneNumber = phoneNumber
//        self.gender = gender
//        self.selectedGenres = selectedGenres
//        self.selectedCinemas = selectedCinemas
//    }

}
