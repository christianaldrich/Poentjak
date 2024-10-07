//
//  EmergencyProsesView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 29/09/24.
//

import SwiftUI

struct EmergencyProsesView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = EmergencyProsesViewModel()
    
    var body: some View {
        VStack {
            Text("Emergency in progress...")
            Text(viewModel.status)
            Button("Delete Emergency") {
//                Task {
//                    await viewModel.deleteEmergency()
//                    presentationMode.wrappedValue.dismiss()
//                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
        }
//        .onAppear{
//            
//            viewModel.fetchEmergency()
//            
//        }
    }
}

#Preview {
    EmergencyProsesView()
}
