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
    @State private var cardNumber: String = ""
    @State private var expiryDate: String = ""
    @State private var cvv: String = ""
    @State private var selectedGiftCard: UUID?
    @State private var promoCode: String = ""
    @State private var orderFinished: Bool = false
    @State private var errorMessage: String?
    
    @State private var cardPaymentRequired: Bool = true
    @State private var paymentBreakdown: [String: Double] = ["GiftCard": 0, "Card": 0]
    
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
                            updateCardPaymentRequirement()
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
                        ForEach(calcPaymentBreakdown(), id: \.self) { detail in
                            Text(detail)
                        }
                    }
                }
                
                // Only show Billing Information if the total balance of selected gift cards doesn't cover the order total
                if totalGiftCardBalance < orderViewModel.totalOrderAmount {
                    Section(header: Text("Billing Information")) {
                        TextField("Name", text: $name)
                            .onChange(of: name) {
                                validateName()
                            }
                        TextField("Card Number", text: $cardNumber)
                            .keyboardType(.numberPad)
                            .onChange(of: cardNumber) {
                                validateCardNumber()
                            }
                        TextField("Expiry Date (MM/YY)", text: $expiryDate)
                            .keyboardType(.numberPad)
                            .onChange(of: expiryDate) {
                                validateExpiry()
                            }
                        TextField("CVV", text: $cvv)
                            .keyboardType(.numberPad)
                            .onChange(of: cvv) {
                                validateCVV()
                            }

                    }
                }
                
                // Show error message if any
                if let errorMessage = errorMessage {
                    Text(errorMessage).foregroundColor(.red).padding()
                }

                Button("Pay") {
                    completePayment()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(isFormValid() ? Color.blue : Color.gray)
                .disabled(!isFormValid())
                .foregroundColor(.white)
                .cornerRadius(10)
//                .padding()
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

    private func validateName() {
        if name.isEmpty {
            errorMessage = "Name cannot be empty"
        } else {
            errorMessage = nil
        }
    }
    
    private func validateCardNumber() {
        if cardNumber.count == 16 && Int(cardNumber) != nil {
            errorMessage = nil
        } else {
            errorMessage = "Card number is invalid"
        }
    }
    
    private func validateExpiry() {
        // Only allow numbers and slashes
        var filtered = expiryDate.filter { "0123456789/".contains($0) }

        // Handle the case where a user might try to delete the slash
        if filtered.count == 3 && filtered.last == "/" && !expiryDate.hasSuffix("/") {
            // If the user is trying to delete the slash, allow it by removing the slash
            filtered = String(filtered.prefix(2))
        } else if filtered.count == 2 && !filtered.contains("/") && expiryDate.hasSuffix("/") {
            // Automatically add slash after 2 digits if not already present
            filtered += "/"
        }

        // Limit length to 5 characters to fit MM/YY
        if filtered.count > 5 {
            filtered = String(filtered.prefix(5))
        }

        // Validate month part to be within 01 to 12 range
        let components = filtered.split(separator: "/")
        if components.count == 2 {
            let monthStr = String(components[0])
            if let month = Int(monthStr), !(1...12).contains(month) {
                // Reset to a valid month if possible, otherwise clear
                filtered = String(month > 12 ? "12/" : filtered.dropLast())
            }
        }

        // Update the expiryDate only if it's different from filtered to avoid recursion
        if filtered != expiryDate {
            expiryDate = filtered
        }
        
        if !isExpiryDateInFuture(expiryDate) {
            errorMessage = "Expiry date is invalid"
        } else {
            errorMessage = nil
        }
    }
    
    private func validateCVV() {
        if cvv.count == 3 && Int(cvv) != nil {
            errorMessage = nil
        } else {
            errorMessage = "CVV is invalid"
        }
    }
    
    private func isExpiryDateInFuture(_ expiryDateStr: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yy"

        if let expiryDate = dateFormatter.date(from: expiryDateStr) {
            let currentDate = Date()
            let currentMonth = Calendar.current.component(.month, from: currentDate)
            let currentYear = Calendar.current.component(.year, from: currentDate) % 100 // last two digits
            let expiryMonth = Calendar.current.component(.month, from: expiryDate)
            let expiryYear = Calendar.current.component(.year, from: expiryDate) % 100 // last two digits

            return (expiryYear > currentYear) || (expiryYear == currentYear && expiryMonth >= currentMonth)
        }
        return false
    }
    
    private func isFormValid() -> Bool {
        // If there is any charge not covered by gift cards, will require form to be filled
        if cardPaymentRequired {
            // If there is a card payment required, simply asset all fields a full, and no errormessage
            return errorMessage == nil && !name.isEmpty && !cardNumber.isEmpty && !expiryDate.isEmpty && !cvv.isEmpty
        } else {
            return errorMessage == nil
        }
    }

    private func updateCardPaymentRequirement() {
        let total = orderViewModel.totalOrderAmount
        let totalGiftCardBalance = orderViewModel.selectedGiftCards.reduce(0) { sum, id in
            sum + (userAccount.giftCards.first(where: { $0.id == id })?.balance ?? 0)
        }

        cardPaymentRequired = total > totalGiftCardBalance
        self.paymentBreakdown["GiftCard"]! += Double(totalGiftCardBalance)
        self.paymentBreakdown["Card"]! += Double(total - totalGiftCardBalance)
    }

    private func calcPaymentBreakdown() -> [String] {
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

    //TODO: move this to viewmodel
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
        
        // Save the order to the user's account
        print("Order Completed")
        userAccount.orders.append(Order(items: orderViewModel.generateAddOns(), tickets: orderViewModel.generateTickets(), cinema: orderViewModel.cinema, session: orderViewModel.session, paymentBreakdown: self.paymentBreakdown))
        
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
