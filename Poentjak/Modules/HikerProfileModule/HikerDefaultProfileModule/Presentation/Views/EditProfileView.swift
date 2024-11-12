//
//  EditProfileView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 10/11/24.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject var authViewModel: AuthViewModel
    @State private var showCamera = false
    @ObservedObject var viewModel : HikerProfileViewModel
    @ObservedObject var navigationManager: MountainNavigationManager
    @State private var isProfileFetched = false
    
    
    
    var body: some View {
        VStack{
            EditPhotoNameComponent(profileURL: viewModel.hikerProfile?.profileURL ?? "", defaultName: viewModel.hikerProfile?.name ?? "" , name: $authViewModel.name){
                //                    self.showCamera.toggle()
                //                Task{
                //                    await viewModel.uploadPhoto(userName: viewModel.name)
                //                    //                await viewModel.editUser()
                //                }
                print("Taken photo!")
            }
            
            EditProfileDescComponent(gender: $authViewModel.gender, age: $authViewModel.age, weight: $authViewModel.weight, height: $authViewModel.height, medicalCondition: $authViewModel.medicalCondition, emergencyContactName: $authViewModel.contactName, emergencyContactNumber: $authViewModel.contactNumber, navigationManager: navigationManager)
            
            Button("save changes"){
                Task{
                    await authViewModel.editUser()
                }
            }
        }
        .onAppear {
            if !isProfileFetched {
                viewModel.fetchHikerProfile()
                isProfileFetched = true  // Mark as fetched
            }
        }
        //        .fullScreenCover(isPresented: self.$showCamera) {
        //            accessCameraView(viewModel: viewModel)
        //                .background(.black)
        //        }
    }
}

//#Preview {
//    EditProfileView()
//}
