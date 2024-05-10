//
//  TicketSelectionView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 8/5/2024.
//

import SwiftUI

struct TicketSelectionView: View {
    let cinema: Cinema
    let session: Session
    @Binding var userAccount: User
    @Binding var isOrdering: Bool

    @State private var tickets: [TicketType: Int] = [.adult: 0, .child: 0, .student: 0, .concession: 0]

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Select Tickets for \(session.movie.name)")) {
                    ForEach(TicketType.allCases, id: \.self) { type in
                        if let binding = Binding($tickets[type]) {
                            TicketCounter(type: type, count: binding)
                        }
                    }
                }
            }
            Spacer()
            NavigationLink("Continue", destination: SeatSelectionView(viewModel: SeatSelectionViewModel(cinema: cinema, session: session, tickets: tickets), userAccount: $userAccount, isOrdering: $isOrdering))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
        }
        .navigationTitle("Ticket Selection")
        .padding(.top)
    }

}


struct TicketCounter: View {
    var type: TicketType
    @Binding var count: Int

    var body: some View {
        HStack {
            Text(type.rawValue)
            Spacer()
            Text("$\(String(format: "%.2f", type.price))")
            Stepper(value: $count, in: 0...10) {
                Text("\(count)")
            }
        }
    }
}

//#Preview {
//    TicketSelectionView()
//}
