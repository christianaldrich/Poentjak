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
    
    @State var oldName: String = ""
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 8){
            HStack{
                Text("Hiker ID")
                    .font(.title1Emphasized)
                    .foregroundStyle(Color.primaryGreen500)
                    .padding(.leading, 18)
                Spacer()
            }
            
            VStack(spacing: 16){
                EditPhotoNameComponent(defaultName: $authViewModel.name, name: $authViewModel.name, authViewModel: authViewModel){
                    self.showCamera.toggle()
                    
                    Task{
                        await authViewModel.updatePhoto(oldPath: oldName, userName: authViewModel.name)
                    }
                    print("Taken photo!")
                }
                
                
//                Text("\(oldName)")
                
                EditProfileDescComponent(gender: $authViewModel.gender, age: $authViewModel.age, weight: $authViewModel.weight, height: $authViewModel.height, medicalCondition: $authViewModel.medicalCondition, emergencyContactName: $authViewModel.contactName, emergencyContactNumber: $authViewModel.contactNumber, navigationManager: navigationManager)
            }
            
            Spacer()
            
//            VStack(alignment: .center){
                CustomLargeButtonComponent(state: .enabled, text: "Save Changes"){
                    Task{
                        await authViewModel.editUser()
                        await authViewModel.updatePhoto(oldPath: oldName, userName: authViewModel.name)
                    }
                    navigationManager.popToPrevious()
                }
//            }
        }
        .padding()
        .onAppear {
            
            if !isProfileFetched {
                viewModel.fetchHikerProfile()
                oldName = authViewModel.name
                isProfileFetched = true
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                    BackButtonComponent{
                        
                    }
            }
        }
        .fullScreenCover(isPresented: self.$showCamera) {
            accessCameraView(viewModel: authViewModel)
                .background(.black)
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
