//
//  ChooseEmergencyTypeView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 09/10/24.
//

import SwiftUI

struct ChooseEmergencyTypeView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject var viewModel: EmergencyProsesViewModel
    
    //    @State var sessionId: String?
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("Select Emergency Type")
                .font(.title3Emphasized)
                .foregroundStyle(Color.primaryGreen500)
                .padding()
            
            Spacer()
            
            VStack(spacing: 10){
                
                HStack{
                    Image.LabelIcon.tap
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 29, height: 29)
                    
                    Text("Tap to alert")
                        .font(.footnoteRegular)
                }
                
                EmergencyButtonComponent(emergencyType: .hypothermia){
                    viewModel.emergencyType = .hipo
                    navigationManager.navigationPath.append(DestinationView.emergencyScale)
                }
                
                EmergencyButtonComponent(emergencyType: .lost){
                    viewModel.emergencyType = .lost
                    navigationManager.navigationPath.append(DestinationView.emergencyScale)
                }
                
                EmergencyButtonComponent(emergencyType: .injury){
                    viewModel.emergencyType = .injury
                    navigationManager.navigationPath.append(DestinationView.emergencyScale)
                }
            }
            
//            Button("Hipotermia") {
//                viewModel.emergencyType = .hipo
//                navigationManager.navigationPath.append(DestinationView.alertGuide)
//                //                navigationManager.navigationPath.append("AlertGuideView")
//            }
//            .frame(maxWidth: .infinity, maxHeight: 50)
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//            .padding()
            
            
//            Button("Lost") {
//                viewModel.emergencyType = .lost
//                navigationManager.navigationPath.append(DestinationView.alertGuide)
//                //                                navigationManager.navigationPath.append("AlertGuideView")
//            }
//            .frame(maxWidth: .infinity, maxHeight: 50)
//            .background(Color.orange)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//            .padding()
//            
//            Button("Injury") {
//                viewModel.emergencyType = .injury
//                navigationManager.navigationPath.append(DestinationView.alertGuide)
//                //                navigationManager.navigationPath.append("AlertGuideView")
//            }
//            .frame(maxWidth: .infinity, maxHeight: 50)
//            .background(Color.red)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//            .padding()
            
            Spacer()
            
            Button("Cancel") {
                navigationManager.navigationPath.removeLast()
            }
            .foregroundStyle(Color.errorRed500)
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)


        
        
    }
}

#Preview {
    ChooseEmergencyTypeView(viewModel: EmergencyProsesViewModel())
        .environmentObject(NavigationManager())
}
