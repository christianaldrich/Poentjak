//
//  FirstNameLastNameView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 29/10/24.
//

import SwiftUI

struct FirstNameLastNameView: View {
    
    @StateObject var viewModel: AuthViewModel
    @State private var isNextViewActive = false
    
    var isNameGenderFilled : Bool{
        !viewModel.name.isEmpty && !viewModel.gender.isEmpty
    }
    
    var body: some View {
        //        NavigationStack{
        ZStack(alignment: .top){
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
            VStack{
                Spacer().frame(height: 65)
                ZStack(alignment:.top){
                    //                CustomIndicatorLongRectangle(totalCount: 4, currentIndex: viewModel.currentIndex)
                    //                    .padding(.top, 50)
                    //                    .zIndex(1)
                    //                NavigationStack{
                    VStack{
                        
                        
                        //                        Spacer().frame(height: 100)
                        
                        VStack(spacing: 40){
                            CustomFullNameTextFieldComponent(name: $viewModel.name)
                            
    //                        Spacer()
                            
                            CustomGenderButtonComponent(gender: $viewModel.gender)
                        }
                        
                        Spacer()
                        
                        CustomLargeButtonComponent(state: isNameGenderFilled ? .enabled : .disabled, text: "Next"){
                            //                            viewModel.storeCurrentNameGender(fullName: fullName, gender: gender)
                            //                            viewModel.updateCurrentIndex(currentIndex: (viewModel.currentIndex ?? 0) + 1)
                            //                            viewModel.fullName = fullName
                            //                            $viewModel.gender = gender
                            viewModel.currentIndex += 1
                            isNextViewActive = true
                        }
                        .disabled(!isNameGenderFilled)
//                        Spacer()
                    }
//                    .padding(.vertical)
                    .navigationDestination(isPresented: $isNextViewActive){
                        ProfilePictureView(viewModel: viewModel)
                    }
                    //                }
                    .navigationBarBackButtonHidden(true)
                }
                
            }
        }
        .padding()
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                BackButtonComponent{
                    //                        viewModel.currentIndex -= 1
                }
                .hidden()
            }
        }
        //            .onAppear{
        //                viewModel.currentIndex = 0
        //            }
        
        
    }
    
    
    //    }
}



//#Preview {
//    //    FirstNameLastNameView(authViewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())))
//    FirstNameLastNameView(viewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())))
//}
