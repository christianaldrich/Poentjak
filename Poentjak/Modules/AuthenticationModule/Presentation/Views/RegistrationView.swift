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
        NavigationStack { // Wrap in NavigationStack
            ZStack {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                VStack {
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
                    
                    VStack(spacing: 20) {
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
                        
                        CustomPrimaryButtonComponent(state: .enabled, text: "Sign up") {
                            print("Sign up button pressed") // Debug print
                            navigateNext = true // Trigger navigation
                            print("Navigating to next: \(navigateNext)") // Debug print
                        }
                        //.disabled(viewModel.isLoading)
                    }
                    .navigationDestination(isPresented: $navigateNext) {
                        RegistrationAgeView(viewModel: viewModel) // Navigate here
                    }
                }
            }
        }
    }
}
