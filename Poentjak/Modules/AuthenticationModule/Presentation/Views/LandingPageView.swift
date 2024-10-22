//
//  LandingPageView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 22/10/24.
//

import SwiftUI

struct LandingPageView: View {
    @StateObject var viewModel: AuthViewModel

    var body: some View {
        NavigationView{
            ZStack{
                
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                VStack{
                    VStack(alignment: .leading) {
                        Text("Welcome to \nPoentjak")
                            .font(.largeTitleEmphasized)
                            
                        
                        Text("A click away from a safe hiking \nexperience.")
                            .font(.title2Regular)
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.primaryGreen500)
                    
                    NavigationLink(destination:                     RegistrationView(viewModel: viewModel)
                        /*.navigationBarBackButtonHidden(true)*/){
                        CustomPrimaryButtonComponent(state: .enabled, text: "Sign up"){
                            print("TEST")
                        }
                        .allowsHitTesting(false)
                    }
                    
                    NavigationLink(destination:                     LoginView(viewModel: viewModel)
                        /*.navigationBarBackButtonHidden(true)*/){
                            CustomPrimaryButtonComponent(state: .secondary, text: "Log in"){
                            print("TEST")
                        }
                        .allowsHitTesting(false)
                    }
                    
                }
                
                
            }
        }
    }
}


struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock use case and view model
        let mockUseCase = DefaultAuthUseCase(
            authRepository: DefaultAuthRepository(),
            userRepository: DefaultUserRepository()
        )
        let mockViewModel = MockAuthViewModel(useCase: mockUseCase)

        // Use the mock view model in the preview
        LandingPageView(viewModel: mockViewModel)
    }
}
