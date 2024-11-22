//
//  OnboardingView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 29/10/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentTab = 0
    private let onboardingDataList = OnboardingData.list
    
    @StateObject var viewModel: AuthViewModel
    
    @State private var buttonState: ButtonState = .enabled
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                TabView(selection: $currentTab) {
                    ForEach(onboardingDataList.indices, id: \.self) { index in
                        OnboardingContent(data: onboardingDataList[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                CustomIndicatorDots(totalDots: onboardingDataList.count, currentIndex: currentTab)
                //.padding(.top, 16)
                    .padding(.bottom, 16)
                
                HStack {
                    if currentTab == onboardingDataList.count - 1 {
                        CustomLargeButtonComponent(state: buttonState, text: "Finish") {
                            
                            Task {
                                buttonState = .loading
                                
                                await viewModel.register()
                                buttonState = .enabled
                                
                            }
                            
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.1)
                //                .background(Color.red)
                //                .frame(height: 60)
            }
            
            
            if currentTab < onboardingDataList.count - 1 {
                Button(action: {
                    currentTab = onboardingDataList.count - 1
                    
                }) {
                    Text("Skip")
                        .font(.headlineRegular)
                        .foregroundColor(Color.primaryGreen500)
                        .padding(.top, 25)
                        .padding(.trailing, 25)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        //        .toolbar{
        //            ToolbarItem(placement: .topBarLeading){
        //                BackButtonComponent{
        //                    viewModel.currentIndex -= 1
        //                }
        //            }
        //        }
    }
}

#Preview {
    OnboardingView(viewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())))
}


