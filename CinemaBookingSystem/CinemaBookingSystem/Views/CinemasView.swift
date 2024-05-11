//
//  CinemasView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct CinemasView: View {
    @ObservedObject var viewModel: CinemasViewModel
    @ObservedObject var moviesViewModel : MoviesViewModel
    @Binding var userAccount: User
    
    @State var isOrdering: Bool = false
    @State private var selectedCinema: Cinema?
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    //show favorites
                    Section(header: Text("Favorite Cinemas")){
                        ForEach(viewModel.getCinemas()) { cinema in
                            if(userAccount.selectedCinemas.contains(cinema.name)){
                                Button(cinema.name) {
                                    selectedCinema = cinema
                                    isOrdering = true
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Other Cinemas")){
                        ForEach(viewModel.getCinemas()) { cinema in
                            if(!userAccount.selectedCinemas.contains(cinema.name)){
                                Button(cinema.name) {
                                    selectedCinema = cinema
                                    isOrdering = true
                                }
                            }
                        }
                    }
                } .navigationTitle("Cinemas")
            }
            .fullScreenCover(isPresented: $isOrdering, onDismiss: {
                // Reset the state when the full screen cover is dismissed
                isOrdering = false
            }) {
                if let cinema = selectedCinema {
                    NavigationView {
                        CinemaView(cinema: cinema, userAccount: $userAccount, isOrdering: $isOrdering)
                            .toolbar {
                               ToolbarItem(placement: .navigationBarLeading) {
                                   Button("Cancel") {
                                       // Code to dismiss the full screen cover
                                       isOrdering = false
                                   }
                               }
                           }
                    }
                }
            }
        }
    }
}

//#Preview {
//    CinemasView(viewModel: SchedulesViewModel())
//}
