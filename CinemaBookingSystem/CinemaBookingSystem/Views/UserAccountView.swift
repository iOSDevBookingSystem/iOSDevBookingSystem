//
//  UserAccountView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct UserAccountView: View {
    @Binding var userAccount: User
    
    private var genres = GenreList.allGenres()
    private var cinemas = CinemaList.allCinemas()
    
    init(userAccount: Binding<User>) {
        self._userAccount = userAccount
    }

    var body: some View {
        Form {
            Section(header: Text("Your Details")) {
                TextField("Name", text: $userAccount.name)
                TextField("Email", text: $userAccount.email)
                TextField("Phone Number", text: $userAccount.phoneNumber)
                    .keyboardType(.phonePad)
                Picker("Gender", selection: $userAccount.gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                }
            }

            Section(header: Text("Favorite Genres")) {
                ForEach(genres, id: \.self) { genre in
                    MultipleSelectionRow(title: genre, isSelected: userAccount.selectedGenres.contains(genre)) {
                        if userAccount.selectedGenres.contains(genre) {
                            userAccount.selectedGenres.remove(genre)
                        } else {
                            userAccount.selectedGenres.insert(genre)
                        }
                    }
                }
            }
            
            Section(header: Text("Favorite Cinemas")) {
                ForEach(cinemas, id: \.self) { cinema in
                    MultipleSelectionRow(title: cinema, isSelected: userAccount.selectedCinemas.contains(cinema)) {
                        if userAccount.selectedCinemas.contains(cinema) {
                            userAccount.selectedCinemas.remove(cinema)
                        } else {
                            userAccount.selectedCinemas.insert(cinema)
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    UserAccountView()
//}
