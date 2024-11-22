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
        Spacer().frame(height: 65)
        VStack(alignment: .leading, spacing: 24) {
//            Spacer().frame(height: 100)
            Text("Who should we call in an emergency?")
                .font(.title3Emphasized)
                .foregroundStyle(Color.primaryGreen500)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 24)
            
            CustomTextFieldEmergencyContactName(text: $viewModel.contactName)
            CustomTextFieldEmergencyContactNumber(text: $viewModel.contactNumber)
            
            Spacer()
            
            CustomLargeButtonComponent(state: isFormFilled ? .enabled : .disabled, text: "Next") {
                if isFormFilled {
                    viewModel.currentIndex += 1
                    navigateToNext = true
                }
            }
            .padding(.horizontal, 24)
            
        }
        .background(
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            hideKeyboard()
                        }
                )
        .padding(.vertical)
        .navigationDestination(isPresented: $navigateToNext) {
            MedicalReportView(viewModel: viewModel)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                BackButtonComponent{
                    viewModel.currentIndex -= 1
                }
            }
        }
    }
}
