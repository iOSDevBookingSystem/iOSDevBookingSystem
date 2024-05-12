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
        isAuthenticated = false
        email = ""
        password = ""
        print("Logging out")
    }
    
    func loggedInUser() -> User? {
        return userAccount
    }
    
    func userExists(email: String) -> Bool {
        return userAccounts.contains { $0.email == email }
    }
    
    private func validCredentials(email: String, password: String) -> User? {
        return userAccounts.first { $0.email == email && $0.password == password }
    }



    func register(user: User, completion: () -> Void, onFailure: () -> Void ) {
        guard !userExists(email: user.email) else { onFailure(); return }
        
        self.userAccounts.append(user)
        completion()
    }
    
}
