//
//  NextViewTest.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 29/10/24.
//

import SwiftUI

struct RegistrationEmergencyContactView: View {
    @StateObject var viewModel: AuthViewModel
    @State private var navigateNext = false
    
    var isFormFilled: Bool {
        !viewModel.contactName.isEmpty && !viewModel.contactNumber.isEmpty
    }
    
    var body: some View {
        
            VStack(alignment: .leading) {  
                Text("Who should we call in an emergency?")
                    .font(.title3Emphasized)
                    .foregroundStyle(Color.primaryGreen500)
                    .padding(.horizontal, 16)
                
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Enter Contact Name", text: $viewModel.contactName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 16)
                    
                    TextField("Enter Contact Number", text: $viewModel.contactNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 16)
                        .keyboardType(.phonePad)
                }
                
                Spacer()
                
                NavigationLink(destination: MedicalReportView(viewModel: viewModel), isActive: $navigateNext) {
                    EmptyView()
                }
                
                CustomLargeButtonComponent(state: isFormFilled ? .enabled : .disabled, text: "Next") {
                    if isFormFilled {
                        navigateNext = true
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    
}


