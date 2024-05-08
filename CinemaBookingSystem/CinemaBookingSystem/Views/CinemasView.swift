//
//  CinemasView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct CinemasView: View {
    //@StateObject var viewModel = CinemasViewModel()
    @ObservedObject var viewModel : SchedulesViewModel
    var body: some View {
        NavigationView {
            List{
                ForEach(viewModel.cinemas.cinemas){ cinema in
                    NavigationLink{
                        CinemaView( viewModel: viewModel, cinema: cinema)
                    }label:{
                        Text(cinema.name)
                    }
                }
            }
            .navigationTitle("Cinemas")
        } 
//    detail:{
//            Text("Select a Cinema")
//        }
    }
}

#Preview {
    CinemasView(viewModel: SchedulesViewModel())
}
