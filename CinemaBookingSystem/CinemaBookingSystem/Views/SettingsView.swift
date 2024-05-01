//
//  SettingsView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        Text("Hello \(mainViewModel.userAccount.name)")
    }
}

//#Preview {
//    SettingsView()
//}
