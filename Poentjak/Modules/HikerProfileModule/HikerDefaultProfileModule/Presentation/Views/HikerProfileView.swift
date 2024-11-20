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
    
    @StateObject var emergencyViewModel: EmergencyProsesViewModel

    @State var isShowDeleteModal: Bool = false
    @State var isShowLogoutModal: Bool = false
    @State var sosGuideModalVisible: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Hiker ID")
                    .font(.title1Emphasized)
                    .foregroundStyle(Color.primaryGreen500)
                    .padding(.leading, 18)
                
                VStack(spacing: 16) {
                    PhotoNameComponent(name: $authViewModel.name, authViewModel: authViewModel)
                    ProfileDescComponent(gender: $authViewModel.gender, age: $authViewModel.age, weight: $authViewModel.weight, height: $authViewModel.height, medicalCondition: $authViewModel.medicalCondition, emergencyContactName: $authViewModel.contactName, emergencyContactNumber: $authViewModel.contactNumber)
                }
                

                VStack(alignment: .leading, spacing: 8) {
                    Button {
                        isShowDeleteModal = true
                    } label: {
                        Text("Delete account")
                            .font(.subheadlineRegular)
                            .foregroundColor(.primaryGreen500)
                    }
                    
                    Button {
//                        if let emailURL = URL(string: "mailto:hikewise.cs@gmail.com") {
//                                UIApplication.shared.open(emailURL)
//                            }
                        if let url = URL(string: "https://hikewise.framer.website/") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("Contact support")
                            .font(.subheadlineRegular)
                            .foregroundColor(.primaryGreen500)
                    }
//                    .disabled(true)
                    
                    Button {
                        if let url = URL(string: "https://hikewise.framer.website/") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("Legal")
                            .font(.subheadlineRegular)
                            .foregroundColor(.primaryGreen500)
                    }
//                    .disabled(true)
                    
//                    Button {
//                        // Placeholder action
//                    } label: {
//                        Text("Password")
//                            .font(.subheadlineRegular)
//                            .foregroundColor(.primaryGreen500)
//                    }
//                    .disabled(true)
                    
                    Divider()
                }
                .padding(.leading, 18)
                
                Button {
                    isShowLogoutModal = true
                } label: {
                    Text("Log Out")
                        .font(.subheadlineRegular)
                        .foregroundColor(.errorRed500)
                }
                .padding(.horizontal, 18)
            }
            .padding()
            .onAppear {
                viewModel.fetchHikerProfile()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButtonComponent {
                        // Back button action
                    }
                    .disabled(isShowLogoutModal || isShowDeleteModal)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") {
                        navigationManager.navigationPath.append(MountainDestinationView.editProfile)
                    }
                    .disabled(isShowLogoutModal || isShowDeleteModal)
                }
            }
            .ignoresSafeArea()
            
            if isShowDeleteModal || isShowLogoutModal {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                if isShowDeleteModal {
                    CustomConfirmationComponent(confirmType: .delete, isModalVisible: $isShowDeleteModal, sosGuideModalVisible: $sosGuideModalVisible) {
                        Task {
                            await authViewModel.deleteAccount()
                            await emergencyViewModel.updateSessionDone()
                        }
                        
                        authViewModel.userSession = nil
                    }
                } else if isShowLogoutModal {
                    CustomConfirmationComponent(confirmType: .logout, isModalVisible: $isShowLogoutModal, sosGuideModalVisible: $sosGuideModalVisible) {
                        Task {
                            await authViewModel.signOut()
                        }
                    }
                }
            }
        }
    }
}
