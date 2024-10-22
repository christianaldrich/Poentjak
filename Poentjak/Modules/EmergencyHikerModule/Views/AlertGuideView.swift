//
//  AlertGuideView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 09/10/24.
//

import SwiftUI

struct AlertGuideView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject var viewModel: EmergencyProsesViewModel
    
    
    var body: some View {
        VStack {
            Text("this is the guide")
                        
            Text("You chose this emergency type: \(viewModel.emergencyType)")
                .font(.largeTitle)
                .padding()
            
            Button("Go to CountDown") {
                navigationManager.navigationPath.append(DestinationView.countDown)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding()
            
            Button("Open Sound Board") {
                navigationManager.navigationPath.append(DestinationView.soundBoard)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding()
            
            
            Button("Cancel") {
                navigationManager.popToRoot()
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AlertGuideView(viewModel: EmergencyProsesViewModel())
        .environmentObject(NavigationManager())
}
