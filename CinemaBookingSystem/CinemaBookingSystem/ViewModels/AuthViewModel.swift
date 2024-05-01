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
    
    private var userAccounts: [User] = []
    var userAccount: User?
    
    init() {
        // Since there is no backend, storing users in this VM. Load in a dummy user
        register(user: User(name: "Peter Parker", email: "peter@spiderman.com", password: "spiderman", phoneNumber: "02 1234 5678", gender: "Male", selectedGenres: Set(["Comedy"]), selectedCinemas:Set(["Cinema 1"]))) {} onFailure: {}
    }
    
    func login(completion: () -> Void, onFailure: () -> Void) {
        self.isLoggingIn = true
        
        if let user = validCredentials(email: self.email, password: self.password) {
            self.isAuthenticated = true
            self.loginError = ""
            self.userAccount = user
            completion()
        } else {
            self.isAuthenticated = false
            self.loginError = "Incorrect email or password. Please try again."
            onFailure()
        }
        
        self.isLoggingIn = false
    }
    
    func logout() {
        self.isAuthenticated = false
        self.userAccount = nil
    }
    
    func loggedInUser() -> User? {
        return userAccount
    }
    
    func userExists(email: String) -> Bool {
        for user in self.userAccounts {
            if email == user.email {
                return true
            }
        }
        return false
    }
    
    private func validCredentials(email: String, password: String) -> User? {
        for user in self.userAccounts {
            if email == user.email && password == user.password {
                return user
            }
        }
        return nil
    }


    func register(user: User, completion: () -> Void, onFailure: () -> Void ) {
        guard !userExists(email: user.email) else { onFailure(); return }
        
        self.userAccounts.append(user)
        completion()
    }
    
}
