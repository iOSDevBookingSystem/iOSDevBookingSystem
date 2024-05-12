//
//  TicketView.swift
//  CinemaBookingSystem
//
//  Created by Daniel Angeloni on 9/5/2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QrCodeView: View {
    let qrString: String
    
    var body: some View {
        Image(uiImage: generateQRCode(from: qrString))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .padding()
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}


struct MovieTicketView: View {
    var ticket: Ticket

    var body: some View {
        VStack(alignment: .leading) {
            Text(ticket.session.movie.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 8)
            Text("Show Time: \(ticket.session.time)")
            Text("Type: \(ticket.type)")
                .padding(.bottom, 16)
            QrCodeView(qrString: "\(ticket.name)")
                        Spacer()
            Spacer()
        }
        .padding()
    }
}

struct TicketView: View {
    var ticket: Ticket

    var body: some View {
        
        MovieTicketView(ticket: ticket)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(20)
                    .padding()
        

            .navigationTitle("Ticket Details")
    }
}

//#Preview {
//    TicketView()
//}
