//
//  LoginView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: AuthViewModel
    @State private var isSubmitted = false
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
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
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color.primaryGreen500)
            
            
            VStack {
                CustomTextFieldAuth(
                    text: $viewModel.email,
                    titleTextField: "Email Address",
                    errorMessage: isSubmitted && !viewModel.email.isValidEmail() ? "Invalid email" : "",
                    isError: isSubmitted && !viewModel.email.isValidEmail(),
                    isPassword: false
                )
                .padding(.bottom, 10)
                
                // Password Field
                CustomTextFieldAuth(
                    text: $viewModel.password,
                    titleTextField: "Password",
                    errorMessage: isSubmitted && viewModel.loginError != nil ? "Incorrect password" : "",
                    isError: isSubmitted && viewModel.loginError != nil,
                    isPassword: true
                )
            }
            
            CustomPrimaryButtonComponent(state: (viewModel.email.isEmpty || viewModel.password.isEmpty) ? .disabled: .enabled, text: "Log in"){
                isSubmitted = true
                Task {
                    
                    await viewModel.login(email: viewModel.email, password: viewModel.password)
                }
            }
            .padding(.top, 12)
            
            NavigationLink {
                Text("Forgot Password?")
            } label: {
                Text("Forgot Password?")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(Color.primaryGreen500)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 5)
            }
            
            Spacer()
            
        }
        .padding(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButtonComponent(action: {
            
        }).padding(.horizontal, 16))
    }
    
}

class MockAuthViewModel: AuthViewModel {
    override init(useCase: DefaultAuthUseCase) {
        super.init(useCase: useCase)
        self.email = "test@example.com" // Example email for preview
        self.password = "password" // Example password for preview
        self.userSession = nil // Set it to nil for login view preview
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock use case and view model
        let mockUseCase = DefaultAuthUseCase(
            authRepository: DefaultAuthRepository(),
            userRepository: DefaultUserRepository()
        )
        let mockViewModel = MockAuthViewModel(useCase: mockUseCase)
        
        // Use the mock view model in the preview
        LoginView(viewModel: mockViewModel)
    }
}


