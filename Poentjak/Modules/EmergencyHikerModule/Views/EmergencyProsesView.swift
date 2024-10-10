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
    @StateObject var navigateViewModel = UserNavigateViewModel(fileName: "")
    
    
    var body: some View {
        
        VStack (alignment: .center){
            
            Button("Top View"){
                
            }
            
            UserNavigateView(viewModel: navigateViewModel)
//                .frame(width: 700, height: 700)
            
//            Text("This is hiking session")
//            
//            Text(viewModel.status)
//                .padding()
//            Text(viewModel.userName)
//                .padding()
//            Text("\(viewModel.dueDate)")
//                .padding()
//            Text("\(viewModel.sessionId)")
//                .padding()
//            MapView()
            

            
            Text("edit time")
            
            Text("SOS")
            
//            Text("I am back at basecamp")
            Button("I am back at basecamp"){
                Task{
                    await viewModel.updateSessionDone()
                    navigateViewModel.isNavigating = false
                    navigateViewModel.stopTimer()
                    navigateViewModel.locationManager.resetTotalDistance()
                    
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
            navigateViewModel.isNavigating = true
            navigateViewModel.startTimer()
        }
    }
}

#Preview {
    EmergencyProsesView()
}
