//
//  SeatSelectionView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct SeatSelectionView: View {
    @ObservedObject var viewModel: SeatSelectionViewModel
    @Binding var userAccount: User

    var body: some View {
        VStack {
            Text("Select your seats for \(viewModel.session.movie.name) at \(viewModel.session.time)")
                .font(.headline)
                .padding()

            if let layout = viewModel.layout {
                ScrollView {
                    // Display seats in rows
                    ForEach(Array(viewModel.seats.keys.sorted()), id: \.self) { row in
                        HStack {
                            // Left seats
                            ForEach(1...layout.leftSeats, id: \.self) { number in
                                seatButton(row: row, number: number)
                            }

                            Spacer()  // Spacer between left and middle seats

                            // Middle seats
                            ForEach(1...layout.middleSeats, id: \.self) { number in
                                seatButton(row: row, number: layout.leftSeats + number)
                            }

                            Spacer()  // Spacer between middle and right seats

                            // Right seats
                            ForEach(1...layout.rightSeats, id: \.self) { number in
                                seatButton(row: row, number: layout.leftSeats + layout.middleSeats + number)
                            }
                        }
                    }
                }
                .padding()
                
                Text("Chosen \(viewModel.selectedSeats.count) out of \(viewModel.maxSeats) seats")
                
                NavigationLink("Continue", destination: AddOnsView(orderViewModel: OrderViewModel(cinema: viewModel.cinema, session: viewModel.session, tickets: viewModel.tickets, userAccount: userAccount, selectedSeats: viewModel.selectedSeats), userAccount: $userAccount))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.selectedAllSeats ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    .disabled(!viewModel.selectedAllSeats)
                
            } else {
                Text("No layout available")
            }
            Spacer()
        }
        .navigationTitle("Select Your Seats")
    }

    private func seatButton(row: String, number: Int) -> some View {
        let seatID = "\(row)\(number)"
        return Button(action: {
            viewModel.toggleSeat(seatID)
        }) {
            Rectangle()
                .foregroundColor(viewModel.selectedSeats.contains(seatID) ? .green :
                                    (viewModel.seats[row]?[seatID] == true ? .gray : .blue))
                .frame(width: 30, height: 30)
                .cornerRadius(5)
        }
        .disabled(viewModel.seats[row]?[seatID] == true)
    }
    
}

//
//#Preview {    
//    var cinemasViewModel: CinemasViewModel = CinemasViewModel()
//    var moviesViewModel: MoviesViewModel = MoviesViewModel()
//    var schedulesViewModel: SchedulesViewModel = SchedulesViewModel()
//    var cinema: Cinema = Cinema(id: 1, name: "Sydney City", address: "George St", rooms: [Room(id: 1, layout: Layout(leftSeats: 2, middleSeats: 5, rightSeats: 2, rowCount: 10))])
//    var movie: Movie = Movie(id: 0, name: "Spider-Man", genre: "Comedy", description: "Movie about spiders")
//    var movieSession: Session = Session(id: 10, cinema: cinema, movie: movie, time: "2024-01-01 11:00:00")
//    schedulesViewModel.addSession(session: movieSession)
//    
//    return SeatSelectionView(viewModel: SeatSelectionViewModel(session: movieSession, maxSeats: 3))
//}
