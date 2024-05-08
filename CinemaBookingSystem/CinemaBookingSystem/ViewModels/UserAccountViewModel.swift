//
//  UserAccountViewModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import Foundation

class UserAccountViewModel: ObservableObject {
    @Published var userAccount: User
    
    init(user: User) {
        self.userAccount = user
    }

}
