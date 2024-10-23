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
        ZStack{
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            VStack {
//                Spacer()
                
//                Image("logo")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 120, height: 120)
//                    .padding()
                VStack(alignment: .leading) {
                    Text("Welcome to \nHikewise")
                        .font(.largeTitleEmphasized)
                        .bold()
                    
                    Text("A click away from a safe hiking \nexperience.")
                        .font(.title2Regular)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.primaryGreen500)
                
                VStack(spacing: 20){
                    VStack {
                        TextField("Enter your email", text: $viewModel.email)
                            .autocapitalization(.none)
                            .modifier(TextFieldModifier())
                        
                        SecureField("Enter your password", text: $viewModel.password)
                            .modifier(TextFieldModifier())
                        
                        
                        if let error = viewModel.loginError {
                            Text(error)
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    
                    CustomPrimaryButtonComponent(state: .enabled, text: "Sign up"){
                        Task {
                            await viewModel.register()
                        }
                    }
                    .disabled(viewModel.isLoading)
                }
                
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
    }
}

//#Preview {
//    RegistrationView(viewModel: AuthViewModel(useCase: DefaultAuthUseCase(repository: DefaultAuthRepository())))
//}
