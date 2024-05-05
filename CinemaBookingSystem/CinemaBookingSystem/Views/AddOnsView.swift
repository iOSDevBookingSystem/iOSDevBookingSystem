//
//  AddOnsView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct AddOnsView: View {
    @StateObject var viewModel = addOnViewModel()
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
            
            NavigationLink{
                //To-do
            } label:{
                ZStack{
                    Rectangle()
                        .fill(.black)
                        .frame(width: 300, height: 40)
                        .cornerRadius(15.0)
                    Text("Add To Order")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    AddOnsView()
}
