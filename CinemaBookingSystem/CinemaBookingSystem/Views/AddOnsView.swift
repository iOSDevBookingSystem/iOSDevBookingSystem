//
//  AddOnsView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct AddOnsView: View {
    @ObservedObject var orderViewModel: OrderViewModel
    @Binding var userAccount: User
    @Binding var isOrdering: Bool

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Select add-ons")) {
                    ForEach(ItemType.allCases, id: \.self) { type in
                        if let binding = Binding($orderViewModel.addOns[type]) {
                            AddOnCounter(type: type, count: binding)
                        }
                    }
                }
            }
            Spacer()
            NavigationLink("Continue", destination: PaymentView(orderViewModel: orderViewModel, userAccount: $userAccount, isOrdering: $isOrdering))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
        }
        .navigationTitle("Add-on Selection")
        .padding(.top)
    }

}

struct AddOnCounter: View {
    var type: ItemType
    @Binding var count: Int

    var body: some View {
        HStack {
            Text(type.rawValue)
            Spacer()
            Text("$\(String(format: "%.2f", type.details.price))")
            Stepper(value: $count, in: 0...10) {
                Text("\(count)")
            }
        }
    }
}



//#Preview {
//    AddOnsView(cinema: Cinema, session: T##Session, tickets: T##[TicketType : Int])
//}
