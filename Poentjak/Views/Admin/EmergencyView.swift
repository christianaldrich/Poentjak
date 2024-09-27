//
//  EmergencyView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import SwiftUI

struct EmergencyView: View {
    @StateObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            Text("Hello, Emergency!")
            
            Button(action: {
                Task {
                    await viewModel.signOut()
                }
                       }) {
                           Text("Sign Out")
                               .font(.headline)
                               .padding()
                               .background(Color.red)
                               .foregroundColor(.white)
                               .cornerRadius(10)
                       }
                       .padding()
        }
        
    }
}


