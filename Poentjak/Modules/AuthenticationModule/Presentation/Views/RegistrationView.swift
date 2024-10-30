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
    
    var body: some View {
  
//            Image("background")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
            
        
            VStack {
//                Spacer()
                
//                Image("logo")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 120, height: 120)
//                    .padding()
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
                
                VStack(spacing: 20){
                    VStack {
//                        TextField("Enter your email", text: $viewModel.email)
//                            .autocapitalization(.none)
//                            .modifier(TextFieldModifier())
//
//                        SecureField("Enter your password", text: $viewModel.password)
//                            .modifier(TextFieldModifier())
//
//
//                        if let error = viewModel.loginError {
//                            Text(error)
//                                .foregroundColor(.red)
//                                .padding()
//                        }
                        CustomTextFieldAuth(text: $viewModel.email, titleTextField: "Email Address", errorMessage: "Email has already been used", isError: false, isPassword: false)
                            .padding(.bottom, 10)
                        
                        CustomTextFieldAuth(text: $viewModel.password, titleTextField: "Password", errorMessage: "Must be at least 8 characters", isError: false, isPassword: true, validationMessage: "Must be at least 8 characters")
                            .padding(.bottom, 10)
                        
                        CustomTextFieldAuth(text: $viewModel.checkPassword, titleTextField: "Confirm Password", errorMessage: "Password do not match", isError: false, isPassword: true, validationMessage: "Both passwords must match")
                    }
                    
                    CustomPrimaryButtonComponent(state: (viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.checkPassword.isEmpty) ? .disabled: .enabled, text: "Sign up"){
                        Task {
                            await viewModel.register()
                        }
                    }
                    .disabled(viewModel.isLoading)
                
                
//                Button {
//                    Task {
//                        await viewModel.register()
//                    }
//
//                } label: {
//                    Text(viewModel.isLoading ? "Signing Up..." : "Sign Up")
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                        .frame(width: 352, height: 44)
//                        .background(.black)
//                        .cornerRadius(8)
//                }
//                .padding(.top, 16)
//                .disabled(viewModel.isLoading)
                
//                Spacer()
//                Divider()
                
//                Button {
//                    dismiss()
//                } label: {
//                    HStack(spacing: 3) {
//                        Text("Already have an account?")
//                        Text("Sign in")
//                            .fontWeight(.semibold)
//                    }
//                    .foregroundColor(.black)
//                    .font(.footnote)
//                }
//                .padding(.vertical, 16)
            }
        }
            .padding(.top, 10)
        
        Spacer()
    }
}

//#Preview {
//    RegistrationView(viewModel: AuthViewModel(useCase: DefaultAuthUseCase(repository: DefaultAuthRepository())))
//}
