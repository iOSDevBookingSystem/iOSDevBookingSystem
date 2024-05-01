//
//  OrderHistoryView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct OrderHistoryView: View {
    @ObservedObject var mainViewModel: MainViewModel

    var body: some View {
        List {
            ForEach(mainViewModel.userAccount.orders, id: \.self) { order in
                Text("Order \(order.id)")
            }
        }
    }
}

//#Preview {
//    OrderHistoryView()
//}
