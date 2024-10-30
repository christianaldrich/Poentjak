//
//  FirstNameLastNameView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 29/10/24.
//

import SwiftUI

struct FirstNameLastNameView: View {
    
    @StateObject var viewModel = HikerRegisViewModel()
    
    @State private var fullName: String = ""
    @State private var buttonCondition: Bool = false
    @State private var gender: String = ""
    
    @State private var isNextViewActive = false // Control navigation
    
    //    @StateObject var authViewModel: AuthViewModel
    
    
    
    var body: some View {
//        NavigationStack{
            
            
            
            
            ZStack(alignment:.top){
                CustomIndicatorLongRectangle(totalCount: 4, currentIndex: viewModel.currentIndex ?? 0)
                    .padding(.top, 50)
                    .zIndex(1)
                NavigationStack{
                    VStack{
        //                Spacer()
                        
                        
                        Spacer()
                        
                        VStack(alignment: .leading){
                            Text("Let's start with your full name")
                                .font(.title3Emphasized)
                                .padding(.leading, 17)
                            TextField("Insert full name", text: $fullName)
                                .padding()
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .padding(.horizontal)
                            
                        }
                        //                .padding()
                        
                        Spacer()
                        
                        VStack(alignment: .leading){
                            
                            Text("As well as your gender.")
                                .font(.title3Emphasized)
                            
                            GenderButtonComponent(genderType: .male, state: gender == "male" ? .enabled : .secondary){
                                gender = "male"
                            }
                            
                            GenderButtonComponent(genderType: .female, state: gender == "female" ? .enabled : .secondary){
                                gender = "female"
                            }
                            
                            GenderButtonComponent(genderType: .others, state: gender == "others" ? .enabled : .secondary){
                                gender = "others"
                            }
                            
                        }
                        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
                        .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 0)
                        
                        Spacer()
                        
                        CustomLargeButtonComponent(state: (fullName.isEmpty || gender.isEmpty) ? .disabled : .enabled, text: "Next"){
                            viewModel.storeCurrentNameGender(fullName: fullName, gender: gender)
                            viewModel.updateCurrentIndex(currentIndex: (viewModel.currentIndex ?? 0) + 1)
                            isNextViewActive = true
                        }
                        .disabled(fullName.isEmpty || gender.isEmpty)
                        
                        
                        
        //                Text("\(String(describing: viewModel.fullName))")
                        
        //                NavigationLink(destination: ProfilePictureView()){
        //                    CustomLargeButtonComponent(state: (fullName.isEmpty || gender.isEmpty) ? .disabled : .enabled, text: "Next") {
        //                        viewModel.storeCurrentNameGender(fullName: fullName, gender: gender, currentIndex: 1)
        //                        //                        isNextViewActive = true
        //                        print("something")
        //                    }
        //                    .allowsHitTesting((fullName.isEmpty || gender.isEmpty))
        //                }
        //                .disabled(fullName.isEmpty || gender.isEmpty)
                        
                        
                        Spacer()
                        
                    }
                    .padding()
                    .navigationDestination(isPresented: $isNextViewActive){
                        ProfilePictureView(viewModel: viewModel)
                    }
                }
            .navigationBarBackButtonHidden(true)
            }
    
            
        }
        
        
//    }
}

#Preview {
    //    FirstNameLastNameView(authViewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())))
    FirstNameLastNameView()
}
