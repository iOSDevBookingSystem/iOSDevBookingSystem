//
//  PaymentView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 8/5/2024.
//

import SwiftUI

struct PaymentView: View {
    @ObservedObject var orderViewModel: OrderViewModel
    var userAccount: User
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var cardNumber: String = ""
    @State private var expiryDate: String = ""
    @State private var cvv: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Order Summary")) {
                    ForEach(orderViewModel.tickets.keys.sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { key in
                        if let count = orderViewModel.tickets[key], count > 0 {
                            HStack {
                                Text("\(key.rawValue) Tickets: \(count)")
                                Spacer()
                                Text("$\(String(format: "%.2f", Double(count) * key.price))")
                            }
                        }
                    }
                }
                
                Section(header: Text("Billing Information")) {
                    TextField("Name", text: $name)
                    TextField("Billing Address", text: $address)
                    TextField("Card Number", text: $cardNumber)
                    TextField("Expiry Date (MM/YY)", text: $expiryDate)
                    TextField("CVV", text: $cvv)
                }
                
                Button("Pay") {
                    // Perform the payment operation
                    navigateToOrderComplete()
                }
            }
            .navigationBarTitle("Complete Your Payment", displayMode: .inline)
        }
    }
    
    private func navigateToOrderComplete() {
        // Navigate to OrderCompleteView
    }
}

struct OrderCompleteView: View {
    var body: some View {
        VStack {
            Text("Thank you for your purchase!")
            Text("Your order has been completed successfully.")
        }
        .navigationTitle("Order Complete")
    }
}
//#Preview {
//    PaymentView()
//}
