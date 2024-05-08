//
//  RegistrationView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct RegistrationView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var phoneNumber: String = ""
    @State var gender: String = ""
    @State var selectedGenres: Set<String> = []
    @State var selectedCinemas: Set<String> = []
    
    @State var errorMessage: String?
    
    @Binding var isPresented: Bool
    
    private let genres = GenreList.allGenres()
    private let cinemas = CinemaList.allCinemas()

    var body: some View {
        VStack {
            Button(action: {
                isPresented = false
            }) {
                Text("Cancel")
            }
            Form {
                Section(header: Text("Your Details")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                        .onChange(of: email) {
                            validateEmail()
                        }
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $password)
                        .onChange(of: confirmPassword) {
                            validatePasswords()
                        }
                    SecureField("Confirm Password", text: $confirmPassword)
                        .onChange(of: confirmPassword) {
                            validatePasswords()
                        }
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                    Picker("Gender", selection: $gender) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                    }
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage).foregroundColor(.red).padding()
                }

                Section(header: Text("Favorite Genres")) {
                    ForEach(genres, id: \.self) { genre in
                        MultipleSelectionRow(title: genre, isSelected: selectedGenres.contains(genre)) {
                            if selectedGenres.contains(genre) {
                                selectedGenres.remove(genre)
                            } else {
                                selectedGenres.insert(genre)
                            }
                        }
                    }
                }
                
                Section(header: Text("Favorite Cinemas")) {
                    ForEach(cinemas, id: \.self) { cinema in
                        MultipleSelectionRow(title: cinema, isSelected: selectedCinemas.contains(cinema)) {
                            if selectedCinemas.contains(cinema) {
                                selectedCinemas.remove(cinema)
                            } else {
                                selectedCinemas.insert(cinema)
                            }
                        }
                    }
                }
                Button("Register") {
                    performRegistration()
                }
                .disabled(!isFormValid())
            }
        }
    }
    
    private func validatePasswords() {
        print("Current password: \(password), Confirm password: \(confirmPassword)")
        if password != confirmPassword {
            errorMessage = "Passwords do not match."
            print("Passwords do not match")
        } else {
            errorMessage = nil
            print("Passwords match")
        }
    }
    
    private func validateEmail() {
        if !email.isValidEmail() {
            errorMessage = "Invalid email format"
        } else if authViewModel.userExists(email: email) {
            errorMessage = "Email already exists"
        } else {
            errorMessage = nil
        }
    }
    
    private func performRegistration() {
        if isFormValid() {
            authViewModel.register(user: User(name: name, email: email, password: password, phoneNumber: phoneNumber, gender: gender, selectedGenres: selectedGenres, selectedCinemas: selectedCinemas)) {
                print("Registered successfully")
                isPresented = false
            } onFailure: {
                errorMessage = "Registration failed"
            }
        }
    }
    
    private func isFormValid() -> Bool {
        errorMessage == nil && password == confirmPassword && email.isValidEmail()
    }
    
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
        }
        .foregroundColor(isSelected ? .blue : .black)
    }
}

//
//#Preview {
//    RegistrationView()
//}
