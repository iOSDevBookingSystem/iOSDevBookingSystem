//
//  AddOnView.swift
//  CinemaBookingSystem
//
//  Created by Mark Jansen Angeles on 5/5/2024.
//

import SwiftUI

struct AddOnView: View {
    @State var consumable: Consuable
    @State private var quantity : Int = 0
    var body: some View {
        HStack{
            VStack{
                HStack{
                    Text(consumable.name)
                        .font(.body)
                    Spacer()
                } .padding(.leading, 10.0)
                HStack{
                    Text(consumable.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }.padding(.leading, 10.0)
            }
            HStack {
                Button(action: {
                    if (quantity > 0){
                        quantity -= 1
                    }},
                       label: {
                    ZStack{
                        Rectangle()
                            .fill(.black)
                            .frame(width: 20, height: 20)
                            .cornerRadius(5.0)
                        Text("-")
                            .foregroundColor(.white)
                    }
                })
                Text("\(quantity)")
                Button(action: {quantity += 1},
                       label: {
                    ZStack{
                        Rectangle()
                            .fill(.black)
                            .frame(width: 20, height: 20)
                            .cornerRadius(5.0)
                        Text("+")
                            .foregroundColor(.white)
                    }
                })
            }.padding()
//            Button(action: { quantity = 0}, label: {
//                ZStack{
//                    Rectangle()
//                        .fill(.black)
//                        .frame(width: 50, height: 35)
//                        .cornerRadius(5.0)
//                    Text("Add")
//                        .foregroundColor(.white)
//                }
//            }).padding()
        }
    }
}

#Preview {
    AddOnView(consumable: Consuable(name: "Reffilable Drink", unit_price: 3.99, category: "Drink", description: "Self-serve refillable drink"))
}
