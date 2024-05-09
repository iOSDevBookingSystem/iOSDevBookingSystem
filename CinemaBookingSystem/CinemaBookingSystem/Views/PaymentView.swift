//
//  PaymentView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 8/5/2024.
//

import SwiftUI

struct PaymentView: View {
    @ObservedObject var orderViewModel: OrderViewModel
    @Binding var userAccount: User
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var cardNumber: String = ""
    @State private var expiryDate: String = ""
    @State private var cvv: String = ""
    @State private var selectedGiftCard: UUID?
    @State private var promoCode: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Order Summary")) {
                    // Show tickets
                    ForEach(orderViewModel.tickets.keys.sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { key in
                        if let count = orderViewModel.tickets[key], count > 0 {
                            HStack {
                                Text("\(key.rawValue) Tickets: \(count)")
                                Spacer()
                                Text("$\(String(format: "%.2f", Double(count) * key.price))")
                            }
                        }
                    }
                    
                    // Show add-ons
                    ForEach(orderViewModel.addOns.keys.sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { itemType in
                        if let count = orderViewModel.addOns[itemType], count > 0 {
                            HStack {
                                Text(itemType.rawValue)
                                Spacer()
                                if let quantity = orderViewModel.addOns[itemType], quantity > 0 {
                                    Text("$\(String(format: "%.2f", Double(quantity) * itemType.details.price))")
                                }
                            }
                        }
                    }
                }

                Section(header: Text("Total")) {
                    let total = orderViewModel.totalOrderAmount
                    Text("Total: $\(String(format: "%.2f", total))")
                }

                Section(header: Text("Gift Cards")) {
                    ForEach(userAccount.giftCards.filter { !$0.isExpired }, id: \.id) { giftCard in
                        Button("\(giftCard.id)") {
                            selectedGiftCard = giftCard.id
                        }
                        .disabled(Date() > giftCard.expirationDate)
                    }
                }

                Section(header: Text("Promo Code")) {
                    TextField("Enter Promo Code", text: $promoCode)
                }

                Section(header: Text("Billing Information")) {
                    TextField("Name", text: $name)
                    TextField("Billing Address", text: $address)
                    TextField("Card Number", text: $cardNumber)
                    TextField("Expiry Date (MM/YY)", text: $expiryDate)
                    TextField("CVV", text: $cvv)
                }

                Button("Pay") {
                    completePayment()
                }
                .disabled(!isFormValid())
            }
            .navigationBarTitle("Complete Your Payment", displayMode: .inline)
        }
    }

    private func isFormValid() -> Bool {
        !name.isEmpty && !address.isEmpty && !cardNumber.isEmpty && !expiryDate.isEmpty && !cvv.isEmpty
    }

    private func completePayment() {
        orderViewModel.completeOrder()
        // Code to navigate back to the main cinemas tab
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
