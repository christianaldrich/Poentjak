//
//  MedicalReportView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 30/10/24.
//

import SwiftUI

struct MedicalReportView: View {
    @StateObject var viewModel: AuthViewModel
    @State private var navigateNext = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Do you have any specific medicinal needs? (optional)")
                .font(.title3Emphasized)
                .foregroundStyle(Color.primaryGreen500)
                .padding(.horizontal, 32)
            
            VStack(alignment: .leading, spacing: 4) {
                CustomTextFieldMedical(text: $viewModel.medicalCondition)
                
                Text("e.g., Asthma")
                    .font(.footnoteRegular)
                    .foregroundColor(.neutralGrayTertiaryGray)
                    .padding(.horizontal, 32)
            }
            
            Spacer()
            
            CustomLargeButtonComponent(state: .enabled, text: "Finish") {
                Task {
                    await viewModel.register()
                }
                navigateNext = true
            }
            .padding(.horizontal, 16)
        }
       
//        .navigationDestination(isPresented: $navigateNext) {
//            //FinalView()
//        }
    }
}
