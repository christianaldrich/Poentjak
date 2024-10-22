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
        NavigationStack {
            ZStack{
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                VStack {
                    
                    Spacer()
            
                    VStack(alignment: .leading) {
                        Text("Welcome to \nPoentjak")
                            .font(.largeTitleEmphasized)
                            .bold()
                        
                        Text("A click away from a safe hiking \nexperience.")
                            .font(.title2Regular)
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.primaryGreen500)

                    
                  
                    VStack {
                        TextField("Enter your email", text: $viewModel.email)
                            .autocapitalization(.none)
                            .modifier(TextFieldModifier())
                        
                        SecureField("Enter your password", text: $viewModel.password)
                            .modifier(TextFieldModifier())
                    }
                    
                    
                   
                    NavigationLink {
                        Text("Forgot Password?")
                    } label: {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.vertical)
                            .padding(.trailing, 28)
                    }
                    
//                    NavigationLink(destination:                     RegistrationView(viewModel: viewModel)
//                        .navigationBarBackButtonHidden(true)){
//                        CustomPrimaryButtonComponent(state: .enabled, text: "Sign up"){
//                            print("TEST")
//                        }
//                        .allowsHitTesting(false)
//                    }
                    
                    CustomPrimaryButtonComponent(state: .enabled, text: "Log in"){
                        Task {
                            await viewModel.login(email: viewModel.email, password: viewModel.password)
                        }
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
            }
        }
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


