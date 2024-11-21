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
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                    .frame(height: 80)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Create an account")
                        .font(.largeTitleEmphasized)
                        .bold()
                    
                    Text("A click away from a safe hiking")
                        .font(.title2Regular)
                    Text("experience.")
                        .font(.title2Regular)
                        .padding(.top, -10)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.primaryGreen500)
                
                VStack {
                    CustomTextFieldAuth(
                        text: $viewModel.email,
                        titleTextField: "Email address",
                        errorMessage: viewModel.registrationError ?? "Email has already been used",
                        isError: viewModel.registrationError != nil,
                        isPassword: false
                    )
                    .padding(.bottom, 10)
                    .onChange(of: viewModel.email) { newValue in
                        viewModel.registrationError = nil
                    }
                    
                    CustomTextFieldAuth(
                        text: $viewModel.password,
                        titleTextField: "Password",
                        errorMessage: "Must be at least 8 characters",
                        isError: viewModel.password.count < 8 && viewModel.password.count != 0,
                        isPassword: true,
                        validationMessage: "Must be at least 8 characters"
                    )
                    .padding(.bottom, 10)
                    
                    CustomTextFieldAuth(
                        text: $viewModel.checkPassword,
                        titleTextField: "Confirm password",
                        errorMessage: viewModel.checkPassword.count < 8 ? "Must be at least 8 characters" : "Passwords do not match",
                        isError: viewModel.password != viewModel.checkPassword || (viewModel.checkPassword.count < 8 && viewModel.checkPassword.count != 0),
                        isPassword: true,
                        validationMessage: "Both passwords must match"
                    )
                    
                    Spacer()
                    
                    CustomPrimaryButtonComponent(
                        state: (viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.checkPassword.isEmpty || viewModel.registrationError != nil) ? .disabled : .enabled,
                        text: "Create an account"
                    ) {
                        Task {
                            if let emailError = await viewModel.validateEmail(email: viewModel.email) {
                                viewModel.registrationError = emailError
                            } else if let passwordError = viewModel.validatePassword() {
                            } else {
                                navigateNext = true
                            }
                        }
                    }
                    .disabled(viewModel.isLoading || viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.checkPassword.isEmpty)
                }
                .navigationDestination(isPresented: $navigateNext) {
                    DisclaimerView(viewModel: viewModel)
                }
                .disabled(viewModel.isLoading)
            }
            .padding(.top, 10)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButtonComponent(action: {
                
            }).padding(.horizontal, 16))
            
            
        }
        .onDisappear {
            if !navigateNext {
                viewModel.clearAll()
            }
        }
    }
}
