//
//  SOSButtonView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 09/10/24.
//

import SwiftUI

struct SOSButtonView: View {
    @Binding var navigationPath: NavigationPath
    
    //    @State var sessionId: String?
    
    
    var body: some View {
        ZStack {
            
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                //                Text("\(sessionId ?? "ADASFDFDF")")
                Text("SOS View")
                    .padding()
                
                //                NavigationLink{
                //                    ChooseEmergencyTypeView(viewModel: EmergencyProsesViewModel(), sessionId: sessionId)
                //                }label: {
                //                    Text("SOS")
                //                        .font(.title)
                //                        .frame(maxWidth: .infinity, maxHeight: 50)
                //                        .background(Color.red)
                //                        .foregroundColor(.white)
                //                        .cornerRadius(8)
                //                        .padding()
                //                }
                //                .simultaneousGesture(TapGesture().onEnded{
                //                    navigationPath.append(DestinationView.chooseEmergency)
                //                })
                
                Button(action: {
                    navigationPath.append(DestinationView.chooseEmergency)
                }) {
                    Text("SOS")
                        .font(.title)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                }
            }
        }
    }
}

//#Preview {
//    SOSButtonView()
//}
