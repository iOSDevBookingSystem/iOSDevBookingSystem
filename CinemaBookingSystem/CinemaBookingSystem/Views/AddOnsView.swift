//
//  AddOnsView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

//for order add-ons
struct AddOnsView: View {
    @StateObject var viewModel = addOnViewModel()
    var orderViewModel: OrderViewModel
    var userAccount: User
    
    init(orderViewModel: OrderViewModel, userAccount: User) {
        self.orderViewModel = orderViewModel
        self.userAccount = userAccount
    }
    
    var body: some View {
        ScrollView{
            HStack{
                Text("Add-ons")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
            }
            ForEach(viewModel.consumables){ consumable in
                AddOnView(consumable: consumable)
            }
            
            NavigationLink("Add To Order", destination: PaymentView(orderViewModel: orderViewModel, userAccount: userAccount))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(15.0)
                .frame(width: 300, height: 40)
                .padding()
        }
    }
}

//#Preview {
//    AddOnsView(cinema: Cinema, session: T##Session, tickets: T##[TicketType : Int])
//}
