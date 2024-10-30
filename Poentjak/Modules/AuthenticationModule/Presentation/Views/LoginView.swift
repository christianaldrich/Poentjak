//
//  LoginView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: AuthViewModel
    
    var body: some View {

        
//            ZStack{
//                Image("background")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)

                
            
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
                    .padding(.horizontal)
                    .padding(.bottom, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.primaryGreen500)
                    
                    
                    
                    //                    VStack {
                    //                        TextField("Enter your email", text: $viewModel.email)
                    //                            .autocapitalization(.none)
                    //                            .modifier(TextFieldModifier())
                    //                        
                    //                        SecureField("Enter your password", text: $viewModel.password)
                    //                            .modifier(TextFieldModifier())
                    //                    }
                    
                    VStack {
                        CustomTextFieldAuth(text: $viewModel.email, titleTextField: "Email Address", errorMessage: "Invalid email", isError: false, isPassword: false)
                            .padding(.bottom, 10)
                        
                        CustomTextFieldAuth(text: $viewModel.password, titleTextField: "Password", errorMessage: "Password incorrect", isError: false, isPassword: true)
                    }
                    
                    
                    //                    NavigationLink(destination:                     RegistrationView(viewModel: viewModel)
                    //                        .navigationBarBackButtonHidden(true)){
                    //                        CustomPrimaryButtonComponent(state: .enabled, text: "Sign up"){
                    //                            print("TEST")
                    //                        }
                    //                        .allowsHitTesting(false)
                    //                    }
                    
                    CustomPrimaryButtonComponent(state: (viewModel.email.isEmpty || viewModel.password.isEmpty) ? .disabled: .enabled, text: "Log in"){
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
                        //.padding(.trailing, 28)
                    }
                    
                    
                    //                    Button {
                    //                        Task {
                    //                            await viewModel.login(email: viewModel.email, password: viewModel.password)
                    //                        }
                    //                    } label: {
                    //                        Text("Login")
                    //                            .font(.subheadline)
                    //                            .fontWeight(.semibold)
                    //                            .foregroundColor(.white)
                    //                            .frame(width: 352, height: 44)
                    //                            .background(.black)
                    //                            .cornerRadius(8)
                    //                    }
                    
                    Spacer()
                    
                    //                    Divider()
                    
                    
                    
                    
                    
                    
                    //                    NavigationLink {
                    //                        RegistrationView(viewModel: viewModel)
                    //                            .navigationBarBackButtonHidden(true)
                    //                    } label: {
                    //                        HStack(spacing: 3) {
                    //                            Text("Don't have an account?")
                    //                            Text("Sign up")
                    //                                .fontWeight(.semibold)
                    //                        }
                    //                        .foregroundColor(.black)
                    //                        .font(.footnote)
                    //                    }
                }
                .padding()
            
//            }
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


