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
    
    @State var sessionId: String?
    
    var body: some View {
        
        VStack {
            Text("\(sessionId ?? "ASDFASTASDF")")
            Text("Choose Emergency Type")
                .font(.title)
                .padding()
            
//            NavigationLink{
//                CountDownView(viewModel: EmergencyProsesViewModel())
//            }label: {
//                Text("asfd")
//            }
//
            // bikin reusable componentnya
            NavigationLink{
                CountDownView(viewModel: EmergencyProsesViewModel(), sessionId: sessionId,emergencyType: "hipotermia")
            }label: {
                Text("Hipotermia")
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }
            .simultaneousGesture(TapGesture().onEnded{
                navigationManager.navigationPath.append(DestinationView.chooseEmergency)
//                navigationManager.navigationPath.append("AlertGuideView")
                viewModel.emergencyType = .lost
                print("\n\n\n\(viewModel.emergencyType)")
            })
            
            
            
            //            Button("Hipotermia") {
            //                viewModel.emergencyType = .hipo
            ////                navigationManager.navigationPath.append(DestinationView.alertGuide)
            ////                navigationManager.navigationPath.append("AlertGuideView")
            //            }
            
            
            Button("Lost") {
                viewModel.emergencyType = .lost
                //                navigationManager.navigationPath.append(DestinationView.alertGuide)
//                                navigationManager.navigationPath.append("AlertGuideView")
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding()
            
            Button("Injury") {
                viewModel.emergencyType = .injury
                //                navigationManager.navigationPath.append(DestinationView.alertGuide)
                //                navigationManager.navigationPath.append("AlertGuideView")
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding()
            
            
            //            Button("Close") {
            //                navigationManager.navigationPath.removeLast()
            //            }
            //            .padding()
        }
        .navigationBarBackButtonHidden(true)
        
        
    }
}

#Preview {
    ChooseEmergencyTypeView(viewModel: EmergencyProsesViewModel())
        .environmentObject(NavigationManager())
}
