//
//  UserAccountView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct UserAccountView: View {
    @ObservedObject var mainViewModel: MainViewModel
    
    private var genres = GenreList.allGenres()
    private var cinemas = CinemaList.allCinemas()
    
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }

    var body: some View {
        Form {
            Section(header: Text("Your Details")) {
                TextField("Name", text: $mainViewModel.userAccount.name)
                TextField("Email", text: $mainViewModel.userAccount.email)
                TextField("Phone Number", text: $mainViewModel.userAccount.phoneNumber)
                    .keyboardType(.phonePad)
                Picker("Gender", selection: $mainViewModel.userAccount.gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                }
            }
            
            // TO-DO: Add button to change password

            Section(header: Text("Favorite Genres")) {
                ForEach(genres, id: \.self) { genre in
                    MultipleSelectionRow(title: genre, isSelected: mainViewModel.userAccount.selectedGenres.contains(genre)) {
                        if mainViewModel.userAccount.selectedGenres.contains(genre) {
                            mainViewModel.userAccount.selectedGenres.remove(genre)
                        } else {
                            mainViewModel.userAccount.selectedGenres.insert(genre)
                        }
                    }
                }
            }
            
            Section(header: Text("Favorite Cinemas")) {
                ForEach(cinemas, id: \.self) { cinema in
                    MultipleSelectionRow(title: cinema, isSelected: mainViewModel.userAccount.selectedCinemas.contains(cinema)) {
                        if mainViewModel.userAccount.selectedCinemas.contains(cinema) {
                            mainViewModel.userAccount.selectedCinemas.remove(cinema)
                        } else {
                            mainViewModel.userAccount.selectedCinemas.insert(cinema)
                        }
                    }
                }
            }

            Button("Save") {
                // TO-DO: Run update user profile function
            }

        }
    }
}

//#Preview {
//    UserAccountView()
//}
