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


// TO-DO: do this
//    func register() {
//
//    }
}
