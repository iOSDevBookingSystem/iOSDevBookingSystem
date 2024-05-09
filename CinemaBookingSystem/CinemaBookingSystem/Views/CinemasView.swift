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
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(viewModel.getCinemas()) { cinema in
                        NavigationLink {
                            CinemaView(cinema: cinema, userAccount: $userAccount)
                        } label: {
                            Text(cinema.name)
                        }
                    }
                }
                .navigationTitle("Cinemas")
            }
        }
    }
}

//#Preview {
//    CinemasView(viewModel: SchedulesViewModel())
//}
