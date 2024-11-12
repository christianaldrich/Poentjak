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
    @State private var isAnimatingGreen = false
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            
            VStack(alignment: .center){
                Text("On a scale 1 - 5 how are")
                    Text("you feeling ?")
            }
            .font(.title3Emphasized)
                    
    //            Text("\(viewModel.emergencyType)")
                Spacer()
                VStack(spacing: 42){
                    EmergencyScaleComponent(viewModel: viewModel)
        //            Text("\(viewModel.emergencyScale)")
                    EmergencyScaleDescComponent(emergencyTypeDesc: viewModel.emergencyType)
                }
            
            
            Spacer()
            
            if viewModel.emergencyScale <= 4{
                CustomLargeButtonComponent(state: .enabled, text: "Next"){
                    
//                    withAnimation(.easeInOut(duration: 1.0)){
                        navigationManager.navigationPath.append(DestinationView.alertGuide)
//                    }
                    
                }
                .opacity(isAnimatingGreen ? 0.2 : 1.0)
                
                
            }
            else{
                
                CustomLargeButtonComponent(state: .danger, text: "Alert ranger"){
//                    withAnimation(.easeInOut(duration: 1.0)){
                        navigationManager.navigationPath.append(DestinationView.countDown)
//                    }

                }
                .opacity(isAnimating ? 1.0 : 0.2)
                
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
                    isAnimatingGreen = true
                }
                else{
                    isAnimating = false
                    isAnimatingGreen = false
                }
                
                

            }
        }
        .onDisappear{
            viewModel.emergencyScale = 1
        }
        
    }
}

//#Preview {
//    EmergencyScaleView()
//}
