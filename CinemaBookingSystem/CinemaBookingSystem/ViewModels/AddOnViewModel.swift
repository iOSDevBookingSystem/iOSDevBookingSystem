//
//  AddOnViewModel.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import Foundation
class addOnViewModel: ObservableObject{
    @Published var consumables: [Consuable] = []
    
    init(){
        consumables.append(Consuable(name: "Regular Popcorn", unit_price: 7.99, category: "Food", description: "Regular sized popcorn"))
        consumables.append(Consuable(name: "Large Popcorn", unit_price: 10.99, category: "Food", description: "Large sized popcorn"))
        consumables.append(Consuable(name: "Reffilable Drink", unit_price: 3.99, category: "Drink", description: "Self-serve refillable drink"))
    }
}
