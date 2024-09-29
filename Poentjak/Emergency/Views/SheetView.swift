//
//  SheetView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 27/09/24.
//

import SwiftUI

struct SheetView: View {
    @StateObject var viewModel = SheetViewModel()
    @State private var navigateToEmergencyProses = false // State to handle navigation
    
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                print("Button 1 tapped")
                Task{
                    await viewModel.createEmergency(type: "type 1")
                    navigateToEmergencyProses = true // Trigger navigation
                    
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            Button("Button 2") {
                print("Button 2 tapped")
                Task{
                    await viewModel.createEmergency(type: "type 2")
                    navigateToEmergencyProses = true // Trigger navigation
                    
                }
                
            }
            .buttonStyle(PlainButtonStyle())
            
            Button("Button 3") {
                print("Button 3 tapped")
                Task{
                    await viewModel.createEmergency(type: "type 3")
                    navigateToEmergencyProses = true // Trigger navigation
                    
                }
                
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        .padding()
        .fullScreenCover(isPresented: $navigateToEmergencyProses) {
                    EmergencyProsesView() // Show EmergencyProsesView when triggered
                }
    }
}

#Preview {
    SheetView()
}
