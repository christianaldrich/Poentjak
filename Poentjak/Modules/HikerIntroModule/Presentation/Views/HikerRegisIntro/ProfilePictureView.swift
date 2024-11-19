//
//  ProfilePictureView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 29/10/24.
//

import SwiftUI
import PhotosUI

struct ProfilePictureView: View {
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State var image: UIImage?
    
    @StateObject var viewModel: AuthViewModel
    @State private var isNextViewActive = false // Control navigation

//    @StateObject var authViewModel: AuthViewModel
    
    
    var body: some View {
        Spacer().frame(height: 100)
        VStack {
            
//            Spacer().frame(height: 100)
            VStack(alignment: .leading, spacing: 8){
                Text("Give us a selfie!")
                    .font(.title3Emphasized)
                Text("We need your profile picture to help rescuers\nidentify you quickly in an emergency!")
                    .font(.subheadlineRegular)
            }
            
//            Text("\(String(describing: viewModel.capturedImage))")
//            PhotoComponent()
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    if let selectedImage = viewModel.capturedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(width: 296, height: 296)
                        
                    }
                }
                
                if viewModel.capturedImage == nil {
                    VStack{
                        TakePhotoComponent {
                            self.showCamera.toggle()
                            
                        }
                        .fullScreenCover(isPresented: self.$showCamera) {
                            accessCameraView(viewModel: viewModel)
                                .background(.black)
                        }
                    }
                } else {
                    
                    VStack{

                        RetakePhotoComponent {
                            self.showCamera.toggle()
                        }
                        .padding(.bottom, -25)
                        .padding(.trailing, 10)
                        .fullScreenCover(isPresented: self.$showCamera) {
                            accessCameraView(viewModel: viewModel)
                                .background(.black)
                        }
                        

                    }
                    
                }
            }
            
            Spacer()
            CustomLargeButtonComponent(state: (viewModel.capturedImage == nil) ? .disabled : .enabled, text: "Next") {
                //upload image
                
                Task{
                    await viewModel.uploadPhoto(userName: viewModel.name)
                }
                
                    viewModel.currentIndex += 1
                    isNextViewActive = true
                }
            .disabled(viewModel.capturedImage == nil)
            
        }
        .padding()
        .navigationDestination(isPresented: $isNextViewActive){
            RegistrationAgeView(viewModel: viewModel)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                BackButtonComponent{
                    viewModel.currentIndex -= 1
                }
            }
        }
        
    }
}

struct accessCameraView: UIViewControllerRepresentable {
    
//    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    @ObservedObject var viewModel: AuthViewModel

    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .front
        imagePicker.cameraFlashMode = .off
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self, viewModel: viewModel)
    }
}

// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    var viewModel: AuthViewModel

    
    init(picker: accessCameraView, viewModel: AuthViewModel) {
        self.picker = picker
        self.viewModel = viewModel

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
//        self.picker.selectedImage = selectedImage
        self.viewModel.capturedImage = selectedImage // Update the view model's captured image
//        print("Image: \(String(describing: self.viewModel.capturedImage))")
//        self.viewModel.storeCurrentProfilePicture(capturedImage: selectedImage)
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

//#Preview {
////    ProfilePictureView(authViewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())))
//    ProfilePictureView()
//}
