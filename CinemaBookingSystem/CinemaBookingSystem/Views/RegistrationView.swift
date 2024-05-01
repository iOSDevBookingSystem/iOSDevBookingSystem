//
//  RegistrationView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct RegistrationView: View {
    @ObservedObject private var viewModel = RegistrationViewModel()
    
    private let genres = GenreList.allGenres()
    private let cinemas = CinemaList.allCinemas()

    var body: some View {
        Form {
            Section(header: Text("Your Details")) {
                TextField("Name", text: $viewModel.name)
                TextField("Email", text: $viewModel.email)
                SecureField("Password", text: $viewModel.password)
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                TextField("Phone Number", text: $viewModel.phoneNumber)
                    .keyboardType(.phonePad)
                Picker("Gender", selection: $viewModel.gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                }
            }

            Section(header: Text("Favorite Genres")) {
                ForEach(genres, id: \.self) { genre in
                    MultipleSelectionRow(title: genre, isSelected: viewModel.selectedGenres.contains(genre)) {
                        if viewModel.selectedGenres.contains(genre) {
                            viewModel.selectedGenres.remove(genre)
                        } else {
                            viewModel.selectedGenres.insert(genre)
                        }
                    }
                }
            }
            
            Section(header: Text("Favorite Cinemas")) {
                ForEach(cinemas, id: \.self) { cinema in
                    MultipleSelectionRow(title: cinema, isSelected: viewModel.selectedCinemas.contains(cinema)) {
                        if viewModel.selectedCinemas.contains(cinema) {
                            viewModel.selectedCinemas.remove(cinema)
                        } else {
                            viewModel.selectedCinemas.insert(cinema)
                        }
                    }
                }
            }

            Button("Register") {
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


#Preview {
    RegistrationView()
}
