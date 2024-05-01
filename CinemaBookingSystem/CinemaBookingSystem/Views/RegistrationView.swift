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
                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirmPassword)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                    Picker("Gender", selection: $gender) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                    }
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
                    authViewModel.register(user: User(name: self.name, email: self.email, password: self.password, phoneNumber: self.phoneNumber, gender: self.gender, selectedGenres: self.selectedGenres, selectedCinemas: self.selectedCinemas)) {
                        print("Registered successfully")
                        isPresented = false
                    } onFailure: {
                        print("Register failed")
                    }
                }
                .disabled(self.password != self.confirmPassword)
            }
        }
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
