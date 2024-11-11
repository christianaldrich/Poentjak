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
        
        ZStack(alignment: .top){
            if viewModel.currentIndex != -1 && viewModel.currentIndex <= 4{
                CustomIndicatorLongRectangle(totalCount: 4, currentIndex: viewModel.currentIndex)
                    .padding(.top, 50)
                    .zIndex(1)
            }
            
            VStack{
                NavigationStack{
                    ZStack{
                        
                        Image("background")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                        VStack{
                            Spacer()
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Welcome to \nHikewise")
                                    .font(.largeTitleEmphasized)
                                    
                                
                                Text("A click away from a safe hiking \nexperience.")
                                    .font(.title2Regular)
                                
                            }
                            .padding(.horizontal, 32)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color.primaryGreen500)
                            .padding(.bottom, 16)
                            
                            NavigationLink(destination:                     RegistrationView(viewModel: viewModel)
                                /*.navigationBarBackButtonHidden(true)*/){
                                CustomPrimaryButtonComponent(state: .enabled, text: "Sign up"){
                                    print("TEST")
                                }
                                .allowsHitTesting(false)
                            }
                            
                            NavigationLink(destination:LoginView(viewModel: viewModel)
                                /*.navigationBarBackButtonHidden(true)*/){
                                    CustomPrimaryButtonComponent(state: .secondary, text: "Log in"){
                                    print("TEST")
                                }
                                .allowsHitTesting(false)
                            }
                            
                        }
                        .padding(.bottom, 195)
                        
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
