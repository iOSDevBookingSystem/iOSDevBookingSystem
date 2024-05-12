//
//  BuyGiftCardView.swift
//  CinemaBookingSystem
//
//  Created by Tong Qian on 9/5/2024.
//

import SwiftUI

struct BuyGiftCardView: View {
    @Binding var userAccount: User
    @Binding var shouldRefresh: Bool // Binding to refresh the previous view
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var cardNumber: String = ""
    @State private var expiryDate: Date = Date()
    @State private var cvv: String = ""
    @State private var Amount: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""


    
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

                // Enter Amount
                Section(header: Text("Amount")) {
                    TextField("Enter amount", text: $Amount)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.decimalPad)
                                    .padding()
                }
                       
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
                
                Button("Pay") {
                    completePayment()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .background(Color.blue)

            }
            .navigationBarTitle("Complete Your Payment", displayMode: .inline)
            .alert(isPresented: $showAlert) {
                            Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
        }
        
    }

    private func completePayment() {
        guard let amountValue = Double(Amount) else {
                    alertMessage = "Please enter a valid amount"
                    showAlert = true
                    return
                }
        let giftCard = GiftCard(amount: amountValue)
        // Save the order to the user's account
        print("Order Completed")
        userAccount.addGiftCard(giftCard)
        
        
        alertMessage = "Successfully purchased a gift card worth $\(amountValue)"
                showAlert = true
        
        // Dismiss the current view after completing payment
        shouldRefresh = true // Set shouldRefresh to true to trigger refresh in the previous view
        presentationMode.wrappedValue.dismiss()
    }
    

}
    

