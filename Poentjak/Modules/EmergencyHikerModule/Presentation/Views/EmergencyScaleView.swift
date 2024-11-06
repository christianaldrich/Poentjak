//
//  EmergencyScaleView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 06/11/24.
//

import SwiftUI

struct EmergencyScaleView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject var viewModel: EmergencyProsesViewModel
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack{
            Text("Emergency Scale View")
            Text("\(viewModel.emergencyType)")
            
            EmergencyScaleComponent(viewModel: viewModel)
//            Text("\(viewModel.emergencyScale)")
            EmergencyScaleDescComponent(emergencyTypeDesc: viewModel.emergencyType)
            
            if viewModel.emergencyScale <= 4{
                CustomLargeButtonComponent(state: .enabled, text: "Next"){
                    
//                    withAnimation(.easeInOut(duration: 1.0)){
                        navigationManager.navigationPath.append(DestinationView.alertGuide)
//                    }
                    
                }
                
                
            }
            else{
                
                CustomLargeButtonComponent(state: .danger, text: "Alert ranger"){
//                    withAnimation(.easeInOut(duration: 1.0)){
                        navigationManager.navigationPath.append(DestinationView.countDown)
//                    }

                }
                .opacity(isAnimating ? 1.0 : 0.8)
                
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                BackButtonComponent{
                    print("back")
                }
            }
        }
        .onChange(of: viewModel.emergencyScale){
            withAnimation(.easeInOut(duration: 0.4)){
                if viewModel.emergencyScale == 5 {
                    isAnimating = true
                }
                else{
                    isAnimating = false
                }

            }
        }
        
    }
}

//#Preview {
//    EmergencyScaleView()
//}
