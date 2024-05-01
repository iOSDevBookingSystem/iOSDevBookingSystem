//
//  AuthViewModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var loginError: String = ""
    @Published var isLoggingIn: Bool = false
    
    // Statically defined users for demonstation
    let userAccount: User
    
    // Create the same user on init. Login would normally set user account after successful login
    init() {
        userAccount = User(name: "Peter Parker", email: "peter@spiderman.com", password: "spiderman", phoneNumber: "02 1234 5678", gender: "Male", selectedGenres: Set(["Comedy"]), selectedCinemas:Set(["Cinema 1"]))
    }
    
    func login(completion: (Bool) -> Void, onFailure: () -> Void) {
        self.isLoggingIn = true
        
        // Simulate a login request to a backend
        if self.email == self.userAccount.email && self.password == self.userAccount.password {
            self.isAuthenticated = true
            self.loginError = ""
            completion(true)
        } else {
            self.isAuthenticated = false
            self.loginError = "Incorrect email or password. Please try again."
            onFailure()
        }
        
        self.isLoggingIn = false
    }
    
// TO-DO: do this
//    func register() {
//
//    }
}
