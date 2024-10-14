//
//  CountDownView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 11/10/24.
//

import SwiftUI

struct CountDownView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject var viewModel: EmergencyProsesViewModel
    
    
    var body: some View {
        VStack{
            Text("This is Count Down View")
            Text("This is the emergency type you chose: \(viewModel.emergencyType)")
                .font(.title)
                .padding()
            
            Text("Count Down: \(viewModel.countDownTime)")
                .font(.title)
                .padding()
            
//            Button("Nanti ini Count Down"){
//                Task{
//                    await viewModel.updateStatusType()
//                    
//                    // ini buat tandain danger di firebase
//                    viewModel.sendSOSToFirebase = true
//                    
//                    // ini buat tutup view sos button
//                    viewModel.showSOSButtonView = false
//                    
//                    // ini ilanin animation
//                    viewModel.deleteAnimation = true
//                    
//                    navigationManager.popToRoot()
//                }
//                
//            }
//            .frame(maxWidth: .infinity, maxHeight: 50)
//            .background(Color.red)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//            .padding()
            
            Button("Cancel") {
                viewModel.cancelCountDown()
                navigationManager.popToRoot()
                
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding()
            
            
        }
        .onAppear{
            viewModel.startCountDown(navigationManager: navigationManager)
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    CountDownView(viewModel: EmergencyProsesViewModel())
        .environmentObject(NavigationManager())
    
}
