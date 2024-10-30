//
//  NextViewTest.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 29/10/24.
//

import SwiftUI

struct RegistrationEmergencyContactView: View {
    @StateObject var viewModel: AuthViewModel
    @State private var navigateToNext = false
    
    var isFormFilled: Bool {
        !viewModel.contactName.isEmpty && !viewModel.contactNumber.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Who should we call in an emergency?")
                .font(.title3Emphasized)
                .foregroundStyle(Color.primaryGreen500)
                .padding(.horizontal, 32)
            
            CustomTextFieldEmergencyContactName(text: $viewModel.contactName)
             CustomTextFieldEmergencyContactNumber(text: $viewModel.contactNumber)
            
            Spacer()
            
            CustomLargeButtonComponent(state: isFormFilled ? .enabled : .disabled, text: "Next") {
                if isFormFilled {
                    navigateToNext = true
                }
            }
            .padding(.horizontal, 32)
        }
        .navigationDestination(isPresented: $navigateToNext) {
            MedicalReportView(viewModel: viewModel)
        }
    }
}
