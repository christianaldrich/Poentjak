//
//  SOSButtonView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 09/10/24.
//

import SwiftUI

struct SOSButtonView: View {
    @Binding var navigationPath: NavigationPath

    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("SOS View")
                    .padding()
                
                Button(action: {
                    navigationPath.append(DestinationView.chooseEmergency)

//                    navigationPath.append("ChooseEmergencyView")
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