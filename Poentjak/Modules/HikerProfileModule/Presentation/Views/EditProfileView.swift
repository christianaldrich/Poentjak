//
//  EditProfileView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 10/11/24.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject var viewModel: AuthViewModel
    @State private var showCamera = false
    
    var body: some View {
        VStack{
            EditPhotoNameComponent(profileURL: viewModel.userSession?.profileURL ?? "" , name: $viewModel.name){
//                    self.showCamera.toggle()
//                Task{
//                    await viewModel.uploadPhoto(userName: viewModel.name)
//                    //                await viewModel.editUser()
//                }
                print("Taken photo!")
            }
            
            Button("save changes"){
                Task{
                    await viewModel.editUser()
                }
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
