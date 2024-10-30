//
//  RegistrationView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//
import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var navigateNext = false
    // @State private var nextView: Bool = false
    
    var body: some View {
        
        
        
        
        Spacer().frame(height: 100)
        
        NavigationStack {
            
            
            VStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Welcome to")
                        .font(.largeTitleEmphasized)
                        .bold()
                    Text("Hikewise")
                        .font(.largeTitleEmphasized)
                        .bold()
                        .padding(.top, -10)
                    
                    Text("A click away from a safe hiking")
                        .font(.title2Regular)
                    Text("experience")
                        .font(.title2Regular)
                        .padding(.top, -10)
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.primaryGreen500)
                
                
                VStack(spacing: 20) {
                    VStack {
                        CustomTextFieldAuth(text: $viewModel.email, titleTextField: "Email Address", errorMessage: "Email has already been used", isError: false, isPassword: false)
                            .padding(.bottom, 10)
                        
                        CustomTextFieldAuth(text: $viewModel.password, titleTextField: "Password", errorMessage: "Must be at least 8 characters", isError: false, isPassword: true, validationMessage: "Must be at least 8 characters")
                            .padding(.bottom, 10)
                        
                        CustomTextFieldAuth(text: $viewModel.checkPassword, titleTextField: "Confirm Password", errorMessage: "Password do not match", isError: false, isPassword: true, validationMessage: "Both passwords must match")
                        
                    }
                    
                    CustomPrimaryButtonComponent(state: (viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.checkPassword.isEmpty) ? .disabled: .enabled, text: "Sign up") {
                        print("Sign up button pressed") // Debug print
                        navigateNext = true // Trigger navigation
                        print("Navigating to next: \(navigateNext)") // Debug print
                    }
                    //.disabled(viewModel.isLoading)
                }
                .navigationDestination(isPresented: $navigateNext) {
                    DisclaimerView(viewModel: viewModel) // Navigate here
                }
                .disabled(viewModel.isLoading)
                
            }
            .padding(.top, 10)
            
            Spacer()
            
        }
        
        
        
        
    }
}
