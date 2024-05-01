//
//  MainViewModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 1/5/2024.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var userAccount: User
    
    init(user: User) {
        self.userAccount = user
    }
}
