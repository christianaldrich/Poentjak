//
//  HikerProfileView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 10/11/24.
//

import SwiftUI

struct HikerProfileView: View {
    @ObservedObject var viewModel = HikerProfileViewModel(authViewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())), hikerProfileUseCase: HikerProfileUseCase(userRepository: DefaultUserRepository()))
    @StateObject var authViewModel: AuthViewModel
    @ObservedObject var navigationManager: MountainNavigationManager
    
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
                    PhotoNameComponent(profileURL: viewModel.hikerProfile?.profileURL ?? "", name: viewModel.hikerProfile?.name ?? "joko")
                    ProfileDescComponent(gender: viewModel.hikerProfile?.gender ?? "", age: viewModel.hikerProfile?.age ?? 0, weight: viewModel.hikerProfile?.weight ?? 0.0, height: viewModel.hikerProfile?.height ?? 0.0, medicalCondition: viewModel.hikerProfile?.medicalRecord ?? "", emergencyContactName: viewModel.hikerProfile?.contactName ?? "", emergencyContactNumber: viewModel.hikerProfile?.contactNumber ?? "")
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
                        // Placeholder action
                    } label: {
                        Text("Contact support")
                            .font(.subheadlineRegular)
                            .foregroundColor(.primaryGreen500)
                    }
                    .disabled(true)
                    
                    Button {
                        // Placeholder action
                    } label: {
                        Text("Legal")
                            .font(.subheadlineRegular)
                            .foregroundColor(.primaryGreen500)
                    }
                    .disabled(true)
                    
                    Button {
                        // Placeholder action
                    } label: {
                        Text("Password")
                            .font(.subheadlineRegular)
                            .foregroundColor(.primaryGreen500)
                    }
                    .disabled(true)
                    
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
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") {
                        navigationManager.navigationPath.append(MountainDestinationView.editProfile)
                    }
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
