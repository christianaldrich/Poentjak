//
//  HikerProfileView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 10/11/24.
//

import SwiftUI

struct HikerProfileView: View {
    @ObservedObject var viewModel : HikerProfileViewModel/*(authViewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())), hikerProfileUseCase: HikerProfileUseCase(userRepository: DefaultUserRepository()))*/
    @StateObject var authViewModel: AuthViewModel
    @ObservedObject var navigationManager: MountainNavigationManager
    @State private var isProfileFetched = false


    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("Hiker ID")
                .font(.title1Emphasized)
                .foregroundStyle(Color.primaryGreen500)
                .padding(.leading, 18)
            
            VStack(spacing: 16){
                PhotoNameComponent(name: $authViewModel.name, authViewModel: authViewModel)
                ProfileDescComponent(gender: $authViewModel.gender, age: $authViewModel.age, weight: $authViewModel.weight, height: $authViewModel.height, medicalCondition: $authViewModel.medicalCondition, emergencyContactName: $authViewModel.contactName, emergencyContactNumber: $authViewModel.contactNumber)
//                ProfileDescComponent(gender: viewModel.hikerProfile?.gender ?? "", age: viewModel.hikerProfile?.age ?? 0, weight: Int(viewModel.hikerProfile?.weight ?? 0), height: Int(viewModel.hikerProfile?.height ?? 0), medicalCondition: viewModel.hikerProfile?.medicalRecord ?? "", emergencyContactName: viewModel.hikerProfile?.contactName ?? "", emergencyContactNumber: viewModel.hikerProfile?.contactNumber ?? "")
            }
            
            VStack(alignment: .leading){
                Button("Contact Support"){
                    
                }
                .disabled(true)
                
                Button("Legal"){
                    
                }
                .disabled(true)
                
                Button("Password"){
                    
                }
                .disabled(true)
                
                Divider()
            }
            .padding(.leading, 18)
            
            Button(action: {
                Task {
                    await authViewModel.signOut()
                }
            }) {
                Text("Sign Out")
                    .font(.headline)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
        }
        .padding()
        .onAppear{
//            if !isProfileFetched {
                viewModel.fetchHikerProfile()
                
//                isProfileFetched = true
//            }
        }
        
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                    BackButtonComponent{
                        
                    }
            }
            ToolbarItem(placement: .topBarTrailing){
                Button("Edit"){
                    navigationManager.navigationPath.append(MountainDestinationView.editProfile)
                }
            }
        }
        .ignoresSafeArea()
    }
}

//#Preview {
//    HikerProfileView(viewModel: AuthViewModel)
//}
