//
//  SettingsView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct SettingsView: View {
    @State var userAccount: User
    
    var body: some View {
        Text("Hello \(userAccount.name)")
    }
}

//#Preview {
//    SettingsView()
//}
