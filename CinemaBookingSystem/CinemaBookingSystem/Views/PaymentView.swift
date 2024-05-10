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
    @Binding var isOrdering: Bool
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var cardNumber: String = ""
    @State private var expiryDate: Date = Date()
    @State private var cvv: String = ""
    @State private var selectedGiftCard: UUID?
    @State private var promoCode: String = ""
    @State private var orderFinished: Bool = false
    
    // Define the range of dates available for the expiry date
    let calendar = Calendar.current
    var expiryDateRange: ClosedRange<Date> {
        let today = Date()
        let farFuture = calendar.date(byAdding: .year, value: 20, to: today)!
        return today...farFuture
    }

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
                
                // Show total order amount
                Section(header: Text("Total")) {
                    let total = orderViewModel.totalOrderAmount
                    Text("Total: $\(String(format: "%.2f", total))")
                }

                // Show gift cards in user's account for them to use
                Section(header: Text("Gift Cards")) {
                    ForEach(userAccount.giftCards.filter { !$0.isValid }, id: \.id) { giftCard in
                        HStack {
                            Text(giftCard.id.uuidString)
                            Spacer()
                            // Show a checkmark if the gift card is selected
                            if orderViewModel.selectedGiftCards.contains(giftCard.id) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                        .onTapGesture {
                            toggleGiftCardSelection(giftCard.id)
                        }
                        .disabled(giftCard.expirationDate < Date())
                    }
                }

                // Enter promo code
                Section(header: Text("Promo Code")) {
                    TextField("Enter Promo Code", text: $promoCode)
                }
                
                // Show Payment information breakdown
                Section(header: Text("Payment Details")) {
                    VStack(alignment: .leading) {
                        ForEach(paymentBreakdown(), id: \.self) { detail in
                            Text(detail)
                        }
                    }
                }
                
                // Only show Billing Information if the total balance of selected gift cards doesn't cover the order total
                if totalGiftCardBalance < orderViewModel.totalOrderAmount {
                    // TODO: add validation to all these including error message
                    Section(header: Text("Billing Information")) {
                        TextField("Name", text: $name)
                        TextField("Billing Address", text: $address)
                        TextField("Card Number", text: $cardNumber)
                            .keyboardType(.numberPad)
                        // TODO: not correct format
                        DatePicker("Expiry Date (MM/YY)", selection: $expiryDate, in: expiryDateRange, displayedComponents: .date)
                            .datePickerStyle(.compact)
                        TextField("CVV", text: $cvv)
                            .keyboardType(.numberPad)
                    }
                }

                Button("Pay") {
                    completePayment()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .background(isFormValid() ? Color.blue : Color.gray)
                .disabled(!isFormValid())
            }
            .navigationBarTitle("Complete Your Payment", displayMode: .inline)
        }
        .fullScreenCover(isPresented: $orderFinished, onDismiss: dismissOrderComplete, content: {
            VStack {
                Text("Thank you \(userAccount.name)!")
                    .font(.title)
                    .padding()
                Text("Your order has been completed successfully.")
                    .padding()
            }
            .navigationTitle("Order Complete")
            
            Button {
                isOrdering = false
            } label: {
                Text("Finish")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        })
    }

    private func isFormValid() -> Bool {
        if totalGiftCardBalance >= orderViewModel.totalOrderAmount {
            return true
        }
        
        let isNameValid = !name.isEmpty
        let isAddressValid = !address.isEmpty
        let isCardNumberValid = cardNumber.count == 16 && Int(cardNumber) != nil

        // Ensure the expiry date is in the future
        let today = Date()
        let isExpiryDateValid = Calendar.current.compare(today, to: expiryDate, toGranularity: .day) == .orderedAscending

        let isCVVValid = cvv.count == 3 && Int(cvv) != nil

        return isNameValid && isAddressValid && isCardNumberValid && isExpiryDateValid && isCVVValid
    }

    private func paymentBreakdown() -> [String] {
        var details: [String] = []
        let total = orderViewModel.totalOrderAmount
        var remainingAmount = total

        for id in orderViewModel.selectedGiftCards {
            if let card = userAccount.giftCards.first(where: { $0.id == id }), remainingAmount > 0 {
                let spendAmount = min(card.balance, remainingAmount)
                details.append("Using $\(String(format: "%.2f", spendAmount)) from Gift Card \(card.id.uuidString)")
                remainingAmount -= spendAmount
            }
        }

        if remainingAmount > 0 {
            details.append("The remaining $\(String(format: "%.2f", remainingAmount)) will be charged to your credit card.")
        } else {
            details.append("The total amount is fully covered by your gift cards.")
        }

        return details
    }

    private func completePayment() {
        var remainingAmount = orderViewModel.totalOrderAmount

        // First, attempt to use the gift cards
        for id in orderViewModel.selectedGiftCards {
            if let index = userAccount.giftCards.firstIndex(where: { $0.id == id }), remainingAmount > 0 {
                let card = userAccount.giftCards[index]
                let spendAmount = min(card.balance, remainingAmount)
                userAccount.giftCards[index].spend(amount: spendAmount)
                remainingAmount -= spendAmount
            }
        }

        // Assume the credit card is charged if there's any remaining amount
        // No actual credit card processing is handled here, as you requested
        
        // Save the order to the user's account
        print("Order Completed")
        userAccount.orders.append(Order(payment_method: "Card", items: orderViewModel.generateAddOns(), tickets: orderViewModel.generateTickets(), cinema: orderViewModel.cinema, session: orderViewModel.session))
        
        // Show cover
        orderFinished = true
        
    }
    
    private func dismissOrderComplete() {
        isOrdering = false
    }
    
    // Calculate total balance from selected gift cards
    private var totalGiftCardBalance: Double {
        orderViewModel.selectedGiftCards.reduce(0) { sum, id in
            sum + (userAccount.giftCards.first(where: { $0.id == id })?.balance ?? 0)
        }
    }
    
    private func toggleGiftCardSelection(_ id: UUID) {
        if orderViewModel.selectedGiftCards.contains(id) {
            orderViewModel.selectedGiftCards.remove(id)
        } else {
            orderViewModel.selectedGiftCards.insert(id)
        }
    }
    
}

//#Preview {
//    PaymentView()
//}
