//
//  AuthView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 30/4/2024.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel: AuthViewModel
    @ObservedObject var schedViewModel: SchedulesViewModel
    @State private var shouldNavigate = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Cinema App Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                VStack(spacing: 15) {
                    TextField("Email", text: $viewModel.email)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                Text(viewModel.loginError)
                    .foregroundColor(.red)
                    .padding()
                
                Button(action: {
                    viewModel.login { _ in
                        shouldNavigate = true
                        print("Logged in successfully")
                    } onFailure: {
                        print("Log in failed")
                    }
                }) {
                    Text("Login")
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
                .navigationDestination(isPresented: $shouldNavigate) {
                    MainView(viewModel: MainViewModel(user: viewModel.userAccount), schedViewModel: schedViewModel)
                }

                NavigationLink("Register", destination: RegistrationView())
                    .padding(.top, 20)
                
                Spacer()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
}



#Preview {
    AuthView(viewModel: AuthViewModel(), schedViewModel: SchedulesViewModel())
}
