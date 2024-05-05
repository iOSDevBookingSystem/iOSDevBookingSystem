//
//  CinemasView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct CinemasView: View {
    @StateObject var viewModel = CinemasViewModel()
    var body: some View {
        NavigationSplitView {
            List{
                ForEach(viewModel.cinemas){ cinema in
                    NavigationLink{
                        CinemaView(cinema: cinema)
                    }label:{
                        Text(cinema.name)
                    }
                }
            }
            .navigationTitle("Cinemas")
        } detail:{
            Text("Select a Cinema")
        }
    }
}

#Preview {
    CinemasView()
}
