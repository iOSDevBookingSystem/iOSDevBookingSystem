//
//  ContentView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 29/4/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authViewModel: AuthViewModel = AuthViewModel()
    
    var body: some View {
        AuthView(viewModel: authViewModel)
    }
}

#Preview {
    ContentView()
}
