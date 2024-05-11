//
//  CinemaSelectionView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 11/5/2024.
//

import SwiftUI

struct CinemaSelectionView: View {
    @ObservedObject var viewModel: CinemasViewModel
    @Binding var userAccount: User
    @Binding var isOrdering : Bool
    @State var movie: Movie
    
    var body: some View {
        List {
            //show favorites first
            Section(header: Text("Favorite Cinemas")){
                ForEach(viewModel.getCinemas()) { cinema in
                    if userAccount.selectedCinemas.contains(cinema.name){
                        NavigationLink(cinema.name){
                            SessionsView(cinema: cinema, movie: movie, userAccount: $userAccount, isOrdering: $isOrdering)
                        }
                    }
                }
            }
            Section(header: Text("Other Cinemas")){
                ForEach(viewModel.getCinemas()) { cinema in
                    if !userAccount.selectedCinemas.contains(cinema.name){
                        NavigationLink(cinema.name){
                            SessionsView(cinema: cinema, movie: movie, userAccount: $userAccount, isOrdering: $isOrdering)
                        }
                    }
                }
            }
            
        }.navigationTitle("Select Cinema")
    }
}

//#Preview {
//    CinemaSelectionView()
//}
