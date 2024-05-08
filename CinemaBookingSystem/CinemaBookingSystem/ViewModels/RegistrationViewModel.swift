//
//  RegistrationViewModel.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var phoneNumber: String = ""
    @Published var gender: String = ""
    @Published var selectedGenres: Set<String> = []
    @Published var selectedCinemas: Set<String> = []

    
    func validPassword() -> Bool {
        // Check the passwords match
        guard self.password == self.confirmPassword else { return false }
        
        // Check the passwords match the policy
        // TO-DO:
        
        return true
    }

    func register(completion: (User) -> Void, onFailure: () -> Void ) {
        // Perform checks to make sure user doesn't already exist
        // This would query a database
        
        // Make sure the password is valid
        if !validPassword() {
            onFailure()
        }
        
        completion(User(name: self.name, email: self.email, password: self.password, phoneNumber: self.phoneNumber, gender: self.gender, selectedGenres: self.selectedGenres, selectedCinemas: self.selectedCinemas))
    }
}
