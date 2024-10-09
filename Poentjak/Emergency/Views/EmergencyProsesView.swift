//
//  EmergencyProsesView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 29/09/24.
//

import SwiftUI

struct EmergencyProsesView: View {
   // @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = EmergencyProsesViewModel()
    
    var body: some View {
        VStack (alignment: .center){
            Text("This is hiking session")
            
            Text(viewModel.status)
                .padding()
            Text(viewModel.userName)
                .padding()
            Text("\(viewModel.dueDate)")
                .padding()
            Text("\(viewModel.sessionId)")
                .padding()

            
            Text("edit time")
            
            Text("SOS")
            
//            Text("I am back at basecamp")
            Button("I am back at basecamp"){
                Task{
                    await viewModel.updateSessionDone()
                    
//                    print("\(viewModel.sessionId)")
//                               presentationMode.wrappedValue.dismiss()
                           
                }
            }
            
//            Button("Delete Emergency") {
//                Task {
//                    await viewModel.deleteEmergency()
//                    presentationMode.wrappedValue.dismiss()
//                }
//            }
//            .buttonStyle(PlainButtonStyle())
//            .padding()
        }
        .onAppear{
            
            viewModel.fetchEmergency()
            
        }
    }
}

#Preview {
    EmergencyProsesView()
}
